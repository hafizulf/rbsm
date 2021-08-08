require_relative '../db/conn'

class Post
    attr_accessor :message, :tags

    def initialize(params)
        @message = params[:message]
        @tags = params[:tags]
    end

    def save
        return chars_length_err unless message_valid?

        client = create_db_client
        client.query("INSERT INTO posts(message, tags) VALUES ('#{message}', '#{tags}') ")
    end

    def message_valid?
        return false unless @message.length <= 1000
        true
    end

    def chars_length_err
        raise "You out of maximum characters length, try below 1000."
    end
end