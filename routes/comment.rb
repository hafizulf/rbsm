require './controller/CommentController'

post '/comment' do
    controller = PostController.new
    controller.save_comment(params)
end