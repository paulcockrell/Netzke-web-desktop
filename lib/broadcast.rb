require 'amqp'
require 'producer'

class Broadcast
  HOST          = '127.0.0.1'
  TIMEOUT       = 2
  ROUTING_KEY   = 'PAUL'
  CONNECTION_SETTINGS = {
                          :host => HOST,
                          :timeout => TIMEOUT,
                          :auto_delete => TRUE
                        }
  RETURN_CODES = {
                   :success_reload   => 1,
                   :success_noreload => 2,
                   :fail_reload      => 3,
                   :fail_noreload    => 4
                 } 

  def initialize(opts={})
    @return_code = RETURN_CODES[opts[:return_code]] || RETURN_CODES[:success_noreload]
    @element_id  = opts[:element_id] || ""
    @message     = opts[:message] || ""
  end

  def message
    puts "1"
    EventMachine.run do
      puts "2"
      AMQP.connect(CONNECTION_SETTINGS) do |connection|
        puts "3"
        connection.on_tcp_connection_loss do |conn, settings|
          Rails.logger.warn "[network failure] Trying to reconnect... settings: #{settings.inspect}"
          conn.reconnect(false, 2)
        end
          
        connection.on_possible_authentication_failure do |conn, settings|
          Rails.logger.warn "[authentication failure]"
          EM.stop
        end

        if connection.connected?
          Rails.logger.info "Established a connection to AMQP broker.."
          channel = AMQP::Channel.new(connection)
          producer = Producer.new(channel, channel.default_exchange)
          message = build_message
          Rails.logger.info "Publishing message: #{message.inspect}"
          producer.publish(message, :routing_key => "system:messages", :persistent => true, :nowait => false) do
            connection.disconnect { EventMachine.stop }
          end
        else
          Rails.logger.warn "Failed to connect to AMQP broker..."
          EventMachine.stop
        end
      end
    end
  end

  private

  def build_message
    "{\"element_id\" : \"#{@element_id}\", \"return_code\" : \"#{@return_code}\", \"message\" : \"#{@message}\"}"
  end
end
