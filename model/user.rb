require './db/conn'

class User
    attr_accessor :id, :username, :email, :bio_desc

    def initialize(param)
        @id = param[:id]
        @username = param[:username]
        @email = param[:email]
        @bio_desc = param[:bio_desc]
    end

    def self.find_all
        client = create_db_client
        rawData = client.query("SELECT * FROM users")
        users = rawData.each
    end

end
