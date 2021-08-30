# frozen_string_literal: true

require_relative '../db/conn'
require './helper/attachment_helper'

class Comment
  attr_accessor :post_id, :comment, :file

  def initialize(params)
    @post_id = params[:post_id]
    @comment = params[:comment]
    @file = params[:file]
    @attachment = AttachmentHelper.new
  end

  def check_post_id
    client = create_db_client
    raw_data = client.query("SELECT id FROM posts WHERE id = '#{post_id}' ")
    raw_data.size
  end

  def save
    return false unless valid?
    raise 'You out of maximum characters length, try below 1000.' unless comment_valid?

    attachment = @attachment.get_file(@file, 'comments')

    # if returned 0 data
    raise 'Post you want to comment not found' if check_post_id < 1

    client = create_db_client
    client.query("INSERT INTO comments(post_id, comment, attachment) VALUES('#{post_id}', '#{comment}', '#{attachment}') ")

    tags = get_tags(@comment)

    tags.each do |tag|
      client.query("INSERT INTO tags(post_id, tag) VALUES('#{post_id}', '#{tag}') ")
    end

    'Successfully commented'
  end

  def get_tags(param)
    param = param.downcase.split(' ')
    arr = param.select { |word| word.start_with?('#') }.uniq
    arr.map { |a| a.delete_prefix('#') }
  end

  def valid?
    return false if post_id.nil?
    return false if comment.nil?

    true
  end

  def comment_valid?
    return false unless comment.length <= 1000

    true
  end
end
