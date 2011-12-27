class DeviceGrid < Netzke::Basepack::GridPanel

  def configuration
    super.merge(
      :model   => "Metric",
      :name    => "deviceGrid",
      :load_inline_data => false,
      :cached  => true,
      :bbar    => nil,
      :tbar => [{
                  :text => "File",
                  :menu => [
                             {
                               :text => 'Exit',
                               :icon => "/images/icons/cross_button.png",
                               :handler => :close_window
                             }
                           ]
               }]
    )
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);
  
      // setting the 'dblclick' event
      this.on('rowdblclick', this.loadDeviceMetricWindow, this);
    }
  JS

  # Event handlers
  js_method :close_window, <<-JS
    function(){
      var win = this.getParent();
      win.close();
    }
  JS

  js_method :load_device_metric_window, <<-JS
    function(self, rowIndex){
      var device_id = 1
      var metric_id = self.store.getAt(rowIndex).id;
      var metric_unit = self.store.getAt(rowIndex).data.unit;

      Ext.getCmp('app').loadChild('DeviceMetricGraphWindow',
				  { newWindow: true,
                                    callback:function(component){
				      component.loadChart({deviceId:device_id,
							   metricId:metric_id,
							   metricUnit:metric_unit},
							   function(){}, that)
				    }
				  });
    }
  JS

  def get_data(*args)
    params = args.first || {} # params are optional!
    id = config[:scope].has_key?(:node_id) ? config[:scope][:node_id] : (raise "???")
    {}.tap do |res|
      records = data_class.find_by_id(id)
      res[:total] = records.length if config[:enable_pagination]
      records = records[(params["start"])..(params["limit"])] if params["start"] && params["limit"]
      res[:data] = records.map{|r| r.to_array(columns(:with_meta => true))}
    end
  end

end
