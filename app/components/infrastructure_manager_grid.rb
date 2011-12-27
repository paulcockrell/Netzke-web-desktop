class InfrastructureManagerGrid < Netzke::Basepack::GridPanel

  def configuration
    super.merge(
      :model   => "Infrastructure",
      :scope   => {:editable => true},
      :title   => "Infrastructure manager",
      :columns => %w{ id label domain grid cluster parent__label },
      :bbar    => nil,
      :tbar => [{
                  :text => "File",
                  :menu => [
                             :add_in_form.action, 
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

  # Event handlers
  js_method :close_window, <<-JS
    function(){
      var win = Ext.getCmp('app__infrastructure_manager_window');
      win.close();
    }
  JS

end
