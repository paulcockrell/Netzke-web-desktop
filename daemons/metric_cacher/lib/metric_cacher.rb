require 'cacher'
require 'net/telnet'
require 'rexml/document'

module MetricCacher
  class Collector
    HOST = '127.0.0.1'
    PORT = '8651'

    def initialize
      @host  = Net::Telnet::new('Host'=>HOST,'Port'=>PORT)
      @cache = MetricCacher::Cacher.new
    end

    def run
      begin
        data = @host.waitfor('</GANGLIAXML>')
        massage_data(data)
      rescue Exception => e
        DaemonKit.logger.warn e.message
        DaemonKit.logger.warn e.backtrace
      end
    end

    private

    def massage_data(data)
      doc = REXML::Document.new(data)
      
      metric_map   = {}
      doc.elements.each("GANGLIA_XML/GRID") do | grid |
        grid_name = grid.attributes['NAME']

        metric_map[grid_name] = {}
        doc.elements.each("GANGLIA_XML/GRID[@NAME='#{grid_name}']/CLUSTER") do | cluster |
          cluster_name = cluster.attributes['NAME']
        
          metric_map[grid_name][cluster_name] = {}
          doc.elements.each("GANGLIA_XML/GRID[@NAME='#{grid_name}']/CLUSTER[@NAME='#{cluster_name}']/HOST") do | host |
            host_name = host.attributes['NAME']
            metric_map[grid_name][cluster_name][host_name] = {}
            metric_map[grid_name][cluster_name][host_name] = {}.tap {|a| host.attributes.each { |attr| a[attr[0]] = attr[1] } }
            
            metric_map[grid_name][cluster_name][host_name]['METRICS'] = {}
            doc.elements.each("GANGLIA_XML/GRID[@NAME='#{grid_name}']/CLUSTER[@NAME='#{cluster_name}']/HOST[@NAME='#{host_name}']/METRIC") do | metric |
              metric_name = metric.attributes['NAME']
              metric_map[grid_name][cluster_name][host_name]['METRICS'][metric_name] = {}
              metric_map[grid_name][cluster_name][host_name]['METRICS'][metric_name] = {}.tap {|a| metric.attributes.each { |attr| a[attr[0]] = attr[1] } }
            end # metric

            store_data("infrastructure:#{grid_name}:#{cluster_name}:#{host_name}", 
                       metric_map[grid_name][cluster_name][host_name]['METRICS'])
          end # host

          hosts = metric_map[grid_name][cluster_name].keys
          cache_host_keys = prefix("infrastructure:#{grid_name}:#{cluster_name}:", hosts)
          store_data("infrastructure:#{grid_name}:#{cluster_name}", cache_host_keys)

        end # cluster
      
        clusters = metric_map[grid_name].keys
        cache_cluster_keys = prefix("infrastructure:#{grid_name}:", clusters)
        store_data("infrastructure:#{grid_name}", cache_cluster_keys)
      
      end # grid

      grids = metric_map.keys
      cache_grid_keys = prefix("infrastructure:", grids)
      store_data("infrastructure", cache_grid_keys)

      nil
    end

    def prefix(prefix, arr)
      [].tap { |el| arr.map { |ar| el << "#{prefix}#{ar}" } }
    end

    def store_data(key, data)
      DaemonKit.logger.info "Storing data..."
      @cache.store(key, data)
    end
  end
end
