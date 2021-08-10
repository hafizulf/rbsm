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

                user = User.find_all

                expect(user).to be_an Enumerator
            end
        end
    end

    describe "save user" do
        context "when given valids params" do
            it "should save user data" do
                mock = "INSERT INTO users(username, email, bio_desc) VALUES ('User', 'user@exp.com', 'Hello!') "

                allow(@client).to receive(:query).with(mock)

                @user.save
            end
        end

        context "when given invalid param" do
            it "should raise a runtime error" do
                user = User.new(email: "tes")

                allow(@client).to receive(:query).with(user)

                expect { user.save }.to raise_error(RuntimeError)
            end
        end
    end

        describe "check valid args" do
            context "when given valid param" do
                it "should return true" do
                    user = User.new(username: "tes")
                    expect(user.valid?).to eq(true)
                end
            end
            context "when given invalid param" do
                it "should return false" do
                    user = User.new(email: "tes")
                    expect(user.valid?).to eq(false)
                end
            end
        end
end