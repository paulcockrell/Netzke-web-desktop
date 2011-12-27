require 'rrd'

class Node < ActiveRecord::Base

  RRD_BASE_PATH = "/var/lib/ganglia/rrds/"
  RRD_SUFFIX    = ".rrd"
  
  belongs_to :node_type
  belongs_to :infrastructure
  belongs_to :operating_system
  has_many   :metrics

  def data_source_name
    "#{hostname}.#{self.infrastructure.domain}"
  end

  def metrics
    # overriding metrics association
    has_metrics? ? Metric.find_by_id(id) : []
  end

  def rrd_fetch(filename, consolidation_function="AVERAGE", start_time=nil, end_time=nil)
      return [] if !has_metrics?
 
      start_time ||= Time.now - 60 * 60
      end_time ||= Time.now
      filename = "#{rrds_path}/#{filename}.rrd"
      data = RRD::Wrapper.fetch(filename, "--start", start_time.to_i.to_s, "--end", end_time.to_i.to_s, consolidation_function)
      data.delete_at(0)
      data = data.select {|d| not d[1].nan?}
      data
  end

  def rrds_path
    return nil if self.infrastructure.cluster.nil? || self.infrastructure.grid.nil?
    File.join(RRD_BASE_PATH, self.infrastructure.cluster, self.hostname) 
  end

  # Let Netzke know this is a virtual model attribute
  netzke_attribute :has_metrics
  def has_metrics?
    return false if rrds_path.nil? 
    File.exists?(rrds_path)
  end

end
