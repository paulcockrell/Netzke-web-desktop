module AdvancedApplicationWindowLayoutHelper

  def format_date(date)
    date.strftime("%a %d-%h-%G")
  end
  
  def infrastructure_info_html(inf)
    return "<h1><i>Unable to locate infrastructure item details</i></h1>" if inf.nil?
    res = "<table>"
    res << "<tr><td>Created:</td><td>#{format_date(inf.created_at)}</td></tr>" unless inf.created_at.nil?
    res << "</table>"
    res
  end

  def job_info_html(job)
    return "<h1><i>Unable to locate job details</i></h1>" if job.nil?
    res = "<table>"
    res << "<tr><td>Job name:</td><td>#{job.label}</td></tr>" unless job.label.empty?
    res << "<tr><td>Job status:</td><td>#{job.success ? "Successful" : "Failed"}</td></tr>"
    res << "<tr><td>Created:</td><td>#{format_date(job.created_at)}</td></tr>" unless job.created_at.nil?
    res << "<tr><td>Last updated:</td><td>#{format_date(job.updated_at)}</td></tr>" unless job.updated_at.nil?
    res << "</table>"
    res
  end
end
