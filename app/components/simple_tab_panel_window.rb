class SimpleTabPanelWindow < MasterWindow
  js_properties :title => "Simple tab panel"

  def default_config
    {
      :name         => "Simple tab panel",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "misc",
      :items        => [{
                          :class_name => "SimpleTabPanel",
        	          :header => false, :border => true
                       }]
    }
  end

end
