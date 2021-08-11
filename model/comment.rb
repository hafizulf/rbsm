require_relative '../db/conn'

class Comment
    attr_accessor :post_id, :comment

    def initialize(params)
        @post_id = params[:post_id]
        @comment = params[:comment]
    end

    def save
        return "ok"
    end
end