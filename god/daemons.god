# run with: god -c /path/to/config.god -D
# 
RAILS_ROOT = "/home/pcockrell/www/Netzke-web-desktop"

%w{comms job_runner metric_cacher}.each do |daemon|
  God.watch do |w|
    w.dir           = "#{RAILS_ROOT}/daemons/#{daemon}"
    w.name          = daemon
    w.group         = "Communications"
    w.interval      = 30.seconds # default      
    w.start         = "/etc/init.d/#{daemon} start"
    w.stop          = "/etc/init.d/#{daemon} stop"
    w.restart       = "/etc/init.d/#{daemon} restart"
    w.start_grace   = 5.seconds
    w.restart_grace = 5.seconds
    w.pid_file      = File.join(RAILS_ROOT, "/tmp/pids/#{daemon}.pid")
    w.log           = "/var/log/#{daemon}.log"
    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end
    
    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 150.megabytes
        c.times = [3, 5] # 3 out of 5 intervals
      end
    
      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
      end
    end
    
    # lifecycle
    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minute
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
      end
    end
  end
end
