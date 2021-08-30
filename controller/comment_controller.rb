# frozen_string_literal: true

require_relative '../model/comment'

class CommentController
  def save_comment(params)
    model = Comment.new(params)
    model.save
  end
end
