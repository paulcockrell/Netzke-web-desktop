class UserFormWindow < MasterWindow
  js_properties :title => "User form"

  def default_config
    {
      :name         => "User form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "UserForm",
        	          :header => false, :border => true
                       }]
    }
  end

end
