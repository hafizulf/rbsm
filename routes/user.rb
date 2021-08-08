require './controller/UserController'

get '/user' do
    controller = UserController.new
    controller.find_all.to_json
end

post '/user' do
    controller = UserController.new
    controller.save(params)
end