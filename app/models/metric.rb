#require 'rrd'

class Metric < ActiveRecord::Base

  class_inheritable_accessor :columns
  self.columns = []
  
  belongs_to :node

#  RRD_BASE_PATH = "/var/lib/ganglia/rrds/"
#  RRD_SUFFIX    = ".rrd"
#  RRD_SUMMARY   = "__SummaryInfo__"
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new( name.to_s, default, sql_type.to_s, null )
  end

  column :label, :string
  column :value, :string
  column :unit,  :string
  column :node_id, :integer

  belongs_to :node, :polymorphic => true

  validates_presence_of :node
  validates_associated  :node
  validates_presence_of :label, :value

  
  def self.find_by_id(id)
 #  data = load_from(path_for(node), node.id)
    node = Node.find(id) rescue nil
    if node
      data = DALLI.get("infrastructure:#{node.infrastructure.grid}:#{node.infrastructure.cluster}:#{node.hostname}")
      return [] if data.nil?

      [].tap do |el|
        data.each_pair do |key, value|
          el << Metric.new(:label=>key, :value=>value['VAL'], :unit=>value['UNITS'], :node_id=>id)
        end
      end
    else
      []
    end
  end

  def self.descends_from_active_record?
    return true
  end

  def persisted?
    return false
  end

  def save( validate = true )
    validate ? valid? : true
  end

  private


#  def self.load_from(path, node_id=nil)
#    metrics = Array.new
#    Dir.foreach(path) do |rrd|
#      next if File.directory?(rrd)
#      data = RRD::Wrapper.last_update!(File.join(path,rrd))
#      metric = Metric.new(:node_id => node_id)
#      metric.label = File.basename(rrd, RRD_SUFFIX)
#      metric.timestamp = data[1][0]
#      metric.value = data[1][1]
#      metrics << metric
#    end
#    metrics
#  rescue Exception=>e
#    []
#  end
#
#  def self.path_for(node)
#    return nil if node.infrastructure.cluster.nil? || node.infrastructure.grid.nil?
#    File.join(RRD_BASE_PATH, node.infrastructure.cluster, node.hostname) 
#  end
#
#  def self.path_for_all
#    File.join(RRD_BASE_PATH, RRD_SUMMARY)
#  end
end
