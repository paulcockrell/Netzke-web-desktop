require 'broadcast'

class LongRunningJob
  attr_accessor :options
  
  def initialize(options = {})
    @element_id  = options[:element_id]
    @job_label   = options[:job_label] || "Unknown job"
    @return_code = options[:return_code] || "success_noreload"
    @sleep_for   = options[:sleep_for] || 10
  end

  def enqueue(job)
    puts ":: Job queued"
  end

  def before(job)
    puts ":: Before job"
  end

  def perform
    puts ":: Performing job #{@job_label} (sleep for #{@sleep_for} seconds)"
    sleep(@sleep_for)
  end

  def after(job)
    puts ":: After job"
  end

  def success(job)
    puts ":: Successful job"
    job = Job.new(:label => @job_label, :infrastructure_id => 3, :success => true)
    job.save
    @message = @job_label + " completed successfully"
    Broadcast.message(FAYE_CHANNEL, @message, :return_code => @return_code, :element_id => @element_id)
  end

  def error(job, exception)
    puts "** ERROR processing job"
    job = Job.new(:label => @job_label, :infrastructure_id => 2, :success => false)
    job.save
    @message = "Error processing " + @job_label
    Broadcast.message(FAYE_CHANNEL, @message, :return_code => @return_code, :element_id => @element_id)
  end

  def failure
    puts "** FAILURE processing job"
  end

end
