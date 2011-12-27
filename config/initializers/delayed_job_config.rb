Delayed::Worker.destroy_failed_jobs = true
#Delayed::Worker.sleep_delay  = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time  = 5.minutes
Delayed::Worker.logger = ActiveSupport::BufferedLogger.new("log/#{Rails.env}_delayed_jobs.log", Rails.logger.level)
Delayed::Worker.logger.auto_flushing = 1
if caller.last =~ /.*\/script\/delayed_job:\d+$/
  ActiveRecord::Base.logger = Delayed::Worker.logger
end
