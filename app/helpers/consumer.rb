class Consumer

  #
  # API
  #

  def handle_message(metadata, payload)
    puts "Received a message: #{payload}, content_type = #{metadata.content_type}"
  end # handle_message(metadata, payload)
end
