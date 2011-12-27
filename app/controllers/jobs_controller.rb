class JobsController < ActionController::Base

  def status
    status = touch_job_status(params[:id])
    if status == "success"
      puts "Job completed successfully!"
      # Success, notify the user!
    elsif status == "failure"
      # Failure, notify the user!
      puts "Job failed"
    end
  end

  private

  def touch_job_status(id)
    job_status = 
      if id.nil? || id.empty?
        "unknown job"
      else
        Delayed::Job.find_by_id(id).nil? ? "success" : (job.last_error.nil? ? "queued" : "failure")
      end

    render :json => job_status
  end

end
