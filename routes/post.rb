require './controller/PostController'

get '/post' do
    controller = PostController.new
    controller.create
end

post '/post' do
    controller = PostController.new
    controller.save(params)
end