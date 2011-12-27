class Queue < Delayed::Job

  def self.poll
    status = status(params[:id])
    if status == "success"
      puts "Job completed successfully!"
      # Success, notify the user!
    elsif status == "failure"
      # Failure, notify the user!
      puts "Job failed"
    end
  end
  

  private

  def status(id)
    self.find_by_id(id).nil? ? "success" : (job.last_error.nil? ? "queued" : "failure")
  end

end
