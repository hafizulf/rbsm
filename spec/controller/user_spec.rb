require_relative "../../controller/UserController"

RSpec.describe UserController do
    user_con = UserController.new

        it "- call find_all" do
            user = double()
            users = [user]
            allow(user).to receive(:id).and_return(1)
            allow(user).to receive(:username).and_return("Dessert")
            allow(User).to receive(:find_all).and_return(users)

            expect(user_con.find_all).to eq(users)
        end

        it "- call user.save" do
            dbl = double
            expect(dbl).to receive(:save)

            allow(User).to receive(:new).and_return(dbl)
            user_con.save({
                username: "user", email: "user@exp.com", bio_desc: "fight!"
            })
        end
end