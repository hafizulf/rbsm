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
            client.query("INSERT INTO post_tags(post_id, tag) VALUES ('#{post_id}', '#{tag}') ")
        end

        true
    end

    def get_tags(param)
        param = param.downcase.split(' ')
        arr = param.select { |word| word.start_with?('#') }.uniq
    end

    def message_valid?
        return false unless @message.length <= 1000
        true
    end

    def chars_length_err
        raise "You out of maximum characters length, try below 1000."
    end

    def self.find_all_post_with_certain_tag(tag)
        client = create_db_client
        rawData = client.query("SELECT id, message FROM posts WHERE tags LIKE '%,#{tag},%' ");
        rawData.each
    end
end