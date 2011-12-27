require 'rubygems'
require 'em-websocket'
require 'amqp'
require 'worker'

module Comms
  class Server
    HOST          = "127.0.0.1"
    PORT          = 8080
    COMMS_CHANNEL = "system:messages"
    TIMEOUT       = 2
    CONNECTION_SETTINGS = {
                            :host => HOST
                          }
                            #:timeout => TIMEOUT

    def self.run
      EventMachine.run {
        DaemonKit.logger.info "Comms eventmachine up, waiting for connections..."
        websocket_connections = []
             
        http = EventMachine::WebSocket.start(:host=>HOST, :port=>PORT) do |ws|
          ws.onopen {
            DaemonKit.logger.info "WebSocket opened, host: #{HOST.inspect}, port: #{PORT.inspect}"
            websocket_connections << ws
      
            #AMQP.start(CONNECTION_SETTINGS) do |connection, open_ok|
            AMQP.connect(CONNECTION_SETTINGS) do |connection|
              channel = AMQP::Channel.new(connection)
              DaemonKit.logger.info "Message queue started, host: #{HOST.inspect}, channel id: #{channel.id.inspect}"
              worker = Comms::Worker.new(channel, COMMS_CHANNEL)
              worker.start do |message|
                DaemonKit.logger.info "Received message via AMQP: #{message}"
                websocket_connections.each do |socket|
                  DaemonKit.logger.info "Sending message via WebSocket: #{message}"
                  socket.send message
                end
              end
            end
          }
      
          ws.onclose {
            DaemonKit.logger.info "WebSocket closed, deleteing connection"
            websocket_connections.delete(ws)
          }
      
        end
      
      }
    end
  end
end
