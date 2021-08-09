require './controller/PostController'

post '/post' do
    controller = PostController.new
    controller.save(params)
end

get '/post/:tag' do
    controller = PostController.new
    controller.post_with_certain_tag(params[:tag]).to_json
end