class DeviceManagerGrid < Netzke::Basepack::GridPanel

  def configuration
    super.merge(
      :name    => "nodes",
      :model   => "Node",
      :prohibit_update => true,
      :title   => "Devices",
      :columns => %w{ ip_address label hostname mac_address node_type__label infrastructure__label },
      :bbar    => nil,
      :tbar => [{
                  :text => "File",
                  :menu => [
                             :add_in_form.action, 
                             {
                               :text => 'Auto scan',
                               :id   => 'scan_network',
                               :handler => :on_scan_network,
                               :icon => "/images/icons/magnifier__arrow.png"
                             },
                             "-",
                             {
                               :text => 'Exit',
                               :icon => "/images/icons/cross_button.png",
                               :handler => :close_window
                             }
                           ]
                },{
                  :text => "Edit",
                  :menu => [
                             :edit_in_form.action,
                             :del.action,
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
      this.on('rowdblclick', this.onSelectionChanged, this);
    }
  JS

  # Event handlers
  js_method :close_window, <<-JS
    function(){
      var win = this.getParent();
      win.close();
    }
  JS

  js_method :on_scan_network, <<-JS
    function(){
      this.el.mask('Processing...','loadingMask');
      this.scanNetwork({el_id: this.id}, function(result) {
                             console.log(result);
                           }, this);
    }
  JS
  
  endpoint :scan_network do |params|
    # pass a code representing the origin of the message,
    # so when the job is completed, and the message returned
    # with the same code via websockets, we know which 
    # window to update etc
    el_id = params[:el_id]
    Delayed::Job.enqueue ScanNetwork.new(:return_code => :success_reload, :element_id => el_id, :message => "Scan network completed")
  end

  # Event handler
  js_method :on_selection_changed, <<-JS
    function(self, rowIndex){
      var device_id = self.store.getAt(rowIndex).get('id');
      that = this;
      Ext.getCmp('app').loadChild('DeviceWindow', 
				  { newWindow: true,
                                    callback:function(component){
				      component.loadData({deviceId:device_id}, function(){}, that)
				    }
				  }
                                 );
    }
  JS

end
