require 'nmap/parser'
require 'broadcast'

class ScanNetwork
  attr_accessor :options
  
  def initialize(options = {})
    @options = options
    @devices = {}
  end

  def enqueue(job)
    Rails.logger.info "## Enqueued job: #{job.inspect}"
  end

  def before(job)
    Rails.logger.info "## Before job!"
  end

  def perform
    Rails.logger.info "## Performing job! with options: #{options.inspect}"
    @counter=0
    np = Nmap::Parser.parsescan("sudo nmap", "sS -O -v -T4 192.168.1.0/24")
    np.hosts("up") do |host|
      node = Node.new
      node.ip_address = host.addr
      node.mac_address = host.mac_addr
      node.save
      Rails.logger.info node.inspect
      @counter += 1
    end
  end

  def after(job)
    Rails.logger.info "## Scanning network completed.<br/> #{@counter} devices found"
  end

  def success(job)
    Rails.logger.info "## START: publish message : #{job.inspect}"
    broadcast = Broadcast.new(:return_code => @options[:return_code], :element_id => @options[:element_id], :message => "Network scan complete")
    broadcast.message
    Rails.logger.info "## END: publish message"
  end

  def error(job, exception)
    Rails.logger.info "## Error job! #{exception.inspect}"
  end

  def failure
    Rails.logger.warn "## OH NO IT FAILED ALL TOGETHER!"
  end

end
