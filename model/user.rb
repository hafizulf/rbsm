# frozen_string_literal: true

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
    raw_data = client.query('SELECT * FROM users')
    raw_data.each
  end

  def save
    raise 'Please provide a username' unless valid?

    client = create_db_client
    client.query("INSERT INTO users(username, email, bio_desc) VALUES ('#{username}', '#{email}', '#{bio_desc}') ")

    'User successfully saved'
  end

  def valid?
    return false if @username.nil?

    true
  end
end
