class SimpleAccordionWindow < MasterWindow
  js_properties :title => "Simple accordion"

  def default_config
    {
      :name         => "Simple accordion",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "SimpleAccordion",
        	          :header => false, :border => true
                       }]
    }
  end

end
