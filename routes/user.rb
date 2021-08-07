require './controller/UserController'

get '/user' do
    controller = UserController.new
    controller.find_all.to_json
end