# frozen_string_literal: true

require_relative '../db/conn'
require './helper/attachment_helper'

class Post
  attr_accessor :message, :file

  def initialize(params)
    @message = params[:message]
    @file = params[:file] # attr: filename, tempfile
    @attachment = AttachmentHelper.new
  end

  def save
    raise 'Please provide a message or message out of maximum characters length, try below 1000.' unless message_valid?

    attachment = @attachment.get_file(@file, 'posts')

    client = create_db_client
    client.query("INSERT INTO posts(message, attachment) VALUES ('#{message}', '#{attachment}') ")

    tags = get_tags(@message)
    post_id = client.last_id
    tags.each do |tag|
      client.query("INSERT INTO tags(post_id, tag) VALUES ('#{post_id}', '#{tag}') ")
    end

    'Post created successfully'
  end

  def get_tags(param)
    param = param.downcase.split(' ')
    arr = param.select { |word| word.start_with?('#') }.uniq
    arr.map { |a| a.delete_prefix('#') }
  end

  def message_valid?
    return false if @message.nil?
    return false unless @message.length <= 1000

    true
  end

  def self.find_all_post_with_certain_tag(tag)
    client = create_db_client
    raw_data = client.query("SELECT id, message, tag FROM posts LEFT JOIN tags ON posts.id = tags.post_id WHERE tag = '#{tag}' ")
    raw_data.each
  end

  def self.find_all_post_with_most_posted_tag
    client = create_db_client
    raw_data = client.query('SELECT tag, COUNT(tag) AS `Total Posted` FROM tags LEFT JOIN posts ON tags.post_id = posts.id LEFT JOIN comments ON comments.post_id = posts.id WHERE created_at >= NOW() - INTERVAL 1 DAY GROUP BY tag ORDER BY `Total Posted` DESC LIMIT 5')
    raw_data.each
  end
end
