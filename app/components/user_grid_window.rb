class UserGridWindow < MasterWindow
  js_properties :title => "User grid"

  def default_config
    {
      :name         => "User grid",
      :width        => "500",
      :height       => "350",
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "users",
      :items        => [{
                          :class_name => "UserGrid",
	        	          :header => false, :border => true
                       }],
      :desktop_icon_cls  => "users",
      :desktop_icon_top  => "50",
      :desktop_icon_left => "50"
    }
  end

end
