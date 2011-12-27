class InfrastructureWindow < MasterWindow
  js_properties :title => "Infrastructure"
  js_mixin :menu
  css_include :menu

  def default_config
    {
      :name         => "Infrastructure",
      :width        => "500",
      :height       => "350",
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "building_network",
      :tbar         => [{
                          :xtype => 'buttongroup',
                          :title   => 'Sample',
                          :columns => 3,
                          :layout  => 'table',
                          :height  => 80,
                          :items   => [{
                                       :text       => 'Hierarchy',
                                       :iconCls    => 'icon-hierarchy',
                                       :rowspan    => '2',
                                       :scale      => 'medium',
                                       :arrowAlign => 'bottom',
                                       :iconAlign  => 'top',
                                       :width      => 50,
                                       :menu       => [{:text=>'pauls menu'}]
                                     },{
                                       :text       => 'Inclusion',
                                       :iconCls    => 'icon-treatment',
                                       :rowspan    => '2',
                                       :scale      => 'medium',
                                       :arrowAlign => 'bottom',
                                       :iconAlign  => 'top',
                                       :width      => 40,
                                       :menu       => [{
                                                       :text    => 'Sample Inclusion Button Menu',
                                       }]
                                     },{
                                       :iconCls    => 'icon-route',
                                       :tooltip    => 'Route',
                                     },{
                                       :iconCls    => 'icon-bandage',
                                       :tooltip    => 'Access Mapping',
                                     }]
                       }],
      :items        => [{
                          :class_name => "InfrastructureLayout",
	        	          :header     => false,
                          :border     => true,
                       }],
      :desktop_icon_cls  => "application_xp",
      :desktop_icon_top  => "50",
      :desktop_icon_left => "50"
    }
  end

end
