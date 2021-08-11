require_relative '../db/conn'

class Comment
    attr_accessor :post_id, :comment

    def initialize(params)
        @post_id = params[:post_id]
        @comment = params[:comment]
    end

    def save
        client = create_db_client
        client.query("INSERT INTO comments(post_id, comment) VALUES('#{post_id}', '#{comment}') ")

        true
    end
end