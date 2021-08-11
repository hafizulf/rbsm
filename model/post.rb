require_relative '../db/conn'

class Post
    attr_accessor :message, :tags, :tag

    def initialize(params)
        @message = params[:message]
        @tags = params[:tags]
    end

    def save
        return chars_length_err unless message_valid?

        client = create_db_client
        client.query("INSERT INTO posts(message) VALUES ('#{message}') ")

        tags = get_tags(@message)
        post_id = client.last_id
        tags.each do |tag|
            client.query("INSERT INTO tags(post_id, tag) VALUES ('#{post_id}', '#{tag}') ")
        end

        true
    end

    def get_tags(param)
        param = param.downcase.split(' ')
        arr = param.select { |word| word.start_with?('#') }.uniq
        arr.map {|a| a.delete_prefix('#')}
    end

    def message_valid?
        return false if @message.nil?
        return false unless @message.length <= 1000
        true
    end

    def chars_length_err
        raise "You need to add some message to post or your message out of maximum characters length, try below 1000."
    end

    def self.find_all_post_with_certain_tag(tag)
        client = create_db_client
        rawData = client.query("SELECT id, message, tag FROM posts LEFT JOIN tags ON posts.id = tags.post_id WHERE tag = '#{tag}' ");
        rawData.each
    end

    def self.find_all_post_with_most_posted_tag
        client = create_db_client
        rawData = client.query("SELECT tag, COUNT(tag) AS `Total Posted` FROM tags LEFT JOIN posts ON tags.post_id = posts.id LEFT JOIN comments ON comments.post_id = posts.id WHERE created_at >= NOW() - INTERVAL 1 DAY GROUP BY tag ORDER BY `Total Posted` DESC LIMIT 5")
        rawData.each
    end
end