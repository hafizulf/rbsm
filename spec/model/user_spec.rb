require_relative '../../model/user'

RSpec.describe User do
    before(:each) do
        @client = double
        @user = User.new(id: 10, username: "User", email: "user@exp.com", bio_desc: "Hello!")
        allow(Mysql2::Client).to receive(:new).and_return(@client)
    end

    describe 'get users' do
        context 'when find_all' do
            it 'should return all users data' do
                mock = "SELECT * FROM users"
                stub = []

                expect(@client).to receive(:query).with(mock).and_return(stub)

                @user = User.find_all

                # expect(@user).to eq(1)
                expect(@user).to be_an Enumerator
            end
        end
    end
end