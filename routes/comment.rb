require './controller/CommentController'

post '/comment' do
    controller = CommentController.new
    controller.save_comment(params)
end