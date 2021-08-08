require_relative '../db/conn'

class Post
    attr_accessor :message, :tags

    def initialize(params)
        @message = params[:message]
        @tags = params[:tags]
    end

    def save
        client = create_db_client
        client.query("INSERT INTO posts(message, tags) VALUES ('#{message}', '#{tags}') ")
    end
end