class UserGridWithCustomizedFormFieldsWindow < MasterWindow
  js_properties :title => "User grid with customized form fields"

  def default_config
    {
      :name         => "User grid with customized form fields",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "UserGridWithCustomizedFormFields",
        	          :header => false, :border => true
                       }]
    }
  end

end
