class Broadcast
  RETURN_CODES = {
                   :success_reload   => 1,
                   :success_noreload => 2,
                   :fail_reload      => 3,
                   :fail_noreload    => 4
                 } 

  def self.message(channel, data, opts={})
    return_code = RETURN_CODES[opts[:return_code]] || RETURN_CODES[:success_noreload]
    element_id  = opts[:element_id] || ""
    message = {
                :channel     => channel,
                :data        => {
                                  :message => data,
                                  :return_code => return_code,
                                  :element_id  => element_id
                                },
                :ext         => {:auth_token => FAYE_TOKEN}
              }

    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
