require_relative '../../model/user'
require 'mysql2'

RSpec.describe User do
    context "#Get" do
        it "- should return a kind of data" do
            stub_client = double
            allow(Mysql2::Client).to receive(:new).and_return(stub_client)
            stub_query = "SELECT * FROM users"

            expect(stub_client).to receive(:query).with(stub_query)
            allow(stub_client).to receive(:query).and_return([
                {"username" => "skuyngoding", "email" => "skuy@ex.com", "bio_desc" => "Rediscover Yourself"}
            ])

            users = User.find_all
            expect(users).to include(a_kind_of(User))

        end
    end
end