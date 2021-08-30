# frozen_string_literal: true

require_relative '../model/user'

class UserController
  def find_all
    User.find_all
  end

  def save(params)
    user = User.new(params)
    user.save
  end
end
