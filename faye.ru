require 'faye'
require File.expand_path('../config/initializers/faye_constants.rb', __FILE__)

class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext']['auth_token'] != FAYE_TOKEN
        puts "Invalid faye token"
        message['error'] = 'Invalid authentication token'
      else
        puts "Valid faye token"
        puts message.inspect
      end
    end
    callback.call(message)
  end
end

faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)
faye_server.add_extension(ServerAuth.new)
run faye_server
