class DeviceWindow < MasterWindow

  def default_config
    {
      :title        => "Device",
      :name         => "Device",
      :width        => "500",
      :height       => "350",
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "device",
      :items        => [:metrics.component(:header=>false, :border=>true, :height=>300)],
      :desktop_icon_cls  => "users",
      :desktop_icon_top  => "50",
      :desktop_icon_left => "50"
    }
  end

  component :metrics do
    {
      :class_name => "DeviceGrid",
      :scope => {:node_id => component_session[:selected_node_id]},
      # always set node_id
      :strong_default_attrs => {:node_id => component_session[:selected_node_id]},
      # do not load data initially
      :load_inline_data => false
    }
  end

  endpoint :load_data do |params|
    component_session[:selected_node_id] = params[:deviceId]
    metrics_grid = component_instance(:metrics)
    metrics_data = metrics_grid.get_data({:cached=>true})
    { :metrics => { :load_store_data => metrics_data } }
  end

end
