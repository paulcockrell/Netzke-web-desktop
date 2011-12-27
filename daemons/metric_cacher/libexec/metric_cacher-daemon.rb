# Change this file to be a wrapper around your daemon code.

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  # config.trap( 'INT' ) do
  #   # do something clever
  # end
  # config.trap( 'TERM', Proc.new { puts 'Going down' } )
end

loop do
  metric_cacher ||= MetricCacher::Collector.new
  
  begin
    DaemonKit.logger.info "Collecting ganglia metrics"
    metric_cacher.run
    DaemonKit.logger.info "Finished collecting ganglia metrics"
  rescue Exception=>e
    metric_cacher = nil
    DaemonKit.logger.info e.message
  end

  DaemonKit.logger.info "Sleeping now"
  sleep 60
end
