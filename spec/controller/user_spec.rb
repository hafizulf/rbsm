require_relative "../../controller/UserController"

RSpec.describe UserController do
    before(:each) do
        @controller =  UserController.new
    end

    it 'should call find_all method' do
        users = double
        expect(User).to receive(:find_all).and_return(users)

        @controller.find_all
    end

    it 'should call save method' do
        stub = double

        allow(User).to receive(:new).with([]).and_return(stub)

        expect(stub).to receive(:save)

        @controller.save([])
    end


end