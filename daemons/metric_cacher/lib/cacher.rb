require 'dalli'
 
module MetricCacher
  class Cacher
    HOST   = '127.0.0.1'
    PORT   = '11211'

    def initialize
      @cache = Dalli::Client::new("#{HOST}:#{PORT}")
    end

    def store(key, data)
      @cache.set(key, data)
    end
  end
end
