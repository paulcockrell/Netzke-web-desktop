class AboutWindow < MasterWindow
  js_properties :title => "About"

  def default_config
    {
      :name         => "About",
      :height       => 200,
      :width        => 300,
      :minimizable  => false,
      :maximizable  => false,
      :persistence  => true,
      :icon_cls     => "about",
      :items        => [{
                          :class_name => "AboutPanel",
	        	          :header => false, :border => false
                       }]
    }
  end

end
