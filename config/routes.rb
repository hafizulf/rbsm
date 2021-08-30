# frozen_string_literal: true

require './controller/user_controller'
require './controller/post_controller'
require './controller/comment_controller'

# user
get '/user' do
  controller = UserController.new
  controller.find_all.to_json
end

post '/user' do
  controller = UserController.new
  controller.save(params).to_json
end

# post
post '/post' do
  controller = PostController.new
  controller.save(params).to_json
end

get '/post/:tag' do
  controller = PostController.new
  controller.post_with_certain_tag(params[:tag]).to_json
end

get '/trend' do
  controller = PostController.new
  controller.post_with_most_posted_tag.to_json
end

# comment
post '/comment' do
  controller = CommentController.new
  controller.save_comment(params).to_json
end
