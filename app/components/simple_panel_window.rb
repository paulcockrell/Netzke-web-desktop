class SimplePanelWindow < MasterWindow
  js_properties :title => "Simple panel"

  def default_config
    {
      :name         => "Simple panel",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "misc",
      :items        => [{
                          :class_name => "SimplePanel",
        	          :header => false, :border => true
                       }]
    }
  end

end
