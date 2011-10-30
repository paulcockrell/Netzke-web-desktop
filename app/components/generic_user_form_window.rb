class GenericUserFormWindow < MasterWindow
  js_properties :title => "Generic user form"

  def default_config
    {
      :name         => "generic user form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "GenericUserForm",
        	          :header => false, :border => true
                       }]
    }
  end

end
