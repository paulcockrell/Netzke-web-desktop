require 'gchart'

class DeviceMetricGraphWindow < MasterWindow
  
  def default_config
    {
      :title        => "Device metric graph",
      :name         => "Device graph",
      :width        => "320",
      :height       => "320",
      :minimizable  => false,
      :maximizable  => false,
      :persistence  => true,
      :icon_cls     => "chart",
      :items        => [{
                          :name => "details",
                          :class_name => "Netzke::Basepack::Panel",
	        	  :header => false, :border => true
                       }],
      :desktop_icon_cls  => "chart",
      :desktop_icon_top  => "50",
      :desktop_icon_left => "50"
    }
  end

  endpoint :load_chart do |params|
    component_id = params[:componentId]
    device_id    = params[:deviceId]
    metric_id    = params[:metricId]
    metric_unit  = params[:metricUnit]

    data = Node.find_by_id(device_id).rrd_fetch(metric_id, "AVERAGE")
    # all time data
    time_points = data.dup.collect {|d| Time.at(d.first.to_i)}
    time_point_min = time_points.min == time_points.max ? (time_points.min-60*60) : time_points.min
    time_point_max = time_points.max
    time_point_step = 5
    # all data data
    data_points = data.dup.collect {|d| d.last}
    data_point_min = data_points.min == data_points.max ? 0 : data_points.min
    data_point_max = data_points.max
    data_point_step = ((data_point_max - data_point_min) / 10).to_i
    chart_image = Gchart.line(:size => '300x300',
			      :title => '',
		      	      :bg => 'ffffff',
	      		      :legend => ["#{metric_id.titlecase} - #{metric_unit}"],
                              :axis_with_labels => ['x','y'],
                              :axis_labels => ["#{time_point_min.hour.to_s}:#{time_point_min.min.to_s}|#{time_point_max.hour.to_s}:#{time_point_max.min.to_s}"],
                              :axis_range => [nil,[data_point_min, data_point_max, data_point_step]],
      			      :data => data_points)
puts chart_image
    {
      :details => {:update_body_html => "<img src='#{chart_image}' alt="" />"}
    }
  end

end
