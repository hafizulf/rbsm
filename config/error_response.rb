# set :environment, :development
set :environment, :production

error do
  content_type :json
  status 400 # or whatever

  e = env['sinatra.error']
  # {:result => 'error', :message => e.message}.to_json
  e.message.to_json
end