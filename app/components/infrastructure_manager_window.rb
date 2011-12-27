class InfrastructureManagerWindow < MasterWindow

  def default_config
    {
      :title        => "Infrastructure manager",
      :name         => "Infrastructure manager",
      :width        => "500",
      :height       => "350",
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "device",
      :items        => [{
                          :class_name => "InfrastructureManagerGrid",
	        	          :header => false, :border => true
                       }],
      :desktop_icon_cls  => "users",
      :desktop_icon_top  => "50",
      :desktop_icon_left => "50"
    }
  end

end
