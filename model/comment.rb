require_relative '../db/conn'
require './helper/file_helper'

class Comment
    attr_accessor :post_id, :comment, :file

    def initialize(params)
        @post_id = params[:post_id]
        @comment = params[:comment]
        @file = params[:file]
    end

    def save
        return false unless valid?
        return chars_length_err unless comment_valid?

        file = AttachmentHelper.new
        attachment = file.get_file(@file)

        client = create_db_client
        client.query("INSERT INTO comments(post_id, comment, attachment) VALUES('#{post_id}', '#{comment}', '#{attachment}') ")

        tags = get_tags(@comment)

        tags.each do |tag|
            client.query("INSERT INTO tags(post_id, tag) VALUES('#{post_id}', '#{tag}') ")
        end

        return "Successfully commented"
    end

    def get_tags(param)
        param = param.downcase.split(' ')
        arr = param.select { |word| word.start_with?('#') }.uniq
        arr.map {|a| a.delete_prefix('#')}
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

    def chars_length_err
        raise "You out of maximum characters length, try below 1000."
    end
end