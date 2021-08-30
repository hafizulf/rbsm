# frozen_string_literal: true

require_relative '../../controller/user_controller'

RSpec.describe UserController do
  before(:each) do
    @controller = UserController.new
    @stub = double
  end

  it 'should call find_all method' do
    expect(User).to receive(:find_all).and_return(@stub)

    @controller.find_all
  end

  it 'should call save method' do
    allow(User).to receive(:new).with([]).and_return(@stub)

    expect(@stub).to receive(:save)

    @controller.save([])
  end
end
