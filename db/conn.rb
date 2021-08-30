# frozen_string_literal: true

require 'mysql2'

def create_db_client
  Mysql2::Client.new(
    host: ENV['DB_HOST'],
    username: ENV['DB_USER'],
    password: ENV['DB_PASS'],
    database: ENV['DB_NAME']
  )
end
