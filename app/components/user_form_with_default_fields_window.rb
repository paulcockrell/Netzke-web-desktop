class UserFormWithDefaultFieldsWindow < MasterWindow
  js_properties :title => "User form with default fields"

  def default_config
    {
      :name         => "User form with default fields",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "UserFormWithDefaultFields",
        	          :header => false, :border => true
                       }]
    }
  end

end
