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
        # users = Array.new
        # rawData.each do | data |
        #     user = User.new({
        #             :username => data['username'], :email => data['email'], :bio_desc => data['bio_desc']
        #         })
        #     users.push(user)
        # end
        # users
    end

    def save
        return false unless valid?

        client = create_db_client
        client.query("INSERT INTO users(username, email, bio_desc) VALUES ('#{username}', '#{email}', '#{bio_desc}') ")
    end

    def valid?
        return false if @username.nil?
        true
    end
end
