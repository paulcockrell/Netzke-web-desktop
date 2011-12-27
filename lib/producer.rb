class Producer

  #
  # API
  #

  def initialize(channel, exchange)
    @channel = channel
    @exchange = exchange
  end # initialize(channel, exchange)

  def publish(message, options = {})
    @exchange.publish(message, options)
  end # publish(message, options = {})


  #
  # Implementation
  #

  def handle_channel_exception(channel, channel_close)
    puts "Oops... a channel-level exception: code = #{channel_close.reply_code}, message = #{channel_close.reply_text}"
  end # handle_channel_exception(channel, channel_close)
end
