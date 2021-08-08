require_relative "../model/user"

class UserController

    def find_all
        User.find_all
    end

    def save(params)
        user = User.new({
            username: params['username'],
            email: params['email'],
            bio_desc: params['bio_desc']
        })
        user.save
    end

end