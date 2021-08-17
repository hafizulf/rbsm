require_relative '../db/conn'

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
        rawData.each
    end

    def save
        return bad_request unless valid?

        client = create_db_client
        client.query("INSERT INTO users(username, email, bio_desc) VALUES ('#{username}', '#{email}', '#{bio_desc}') ")

        return "User successfully saved"
    end

    def valid?
        return false if @username.nil?
        true
    end

    def bad_request
        raise "Please provide a username"
    end
end
