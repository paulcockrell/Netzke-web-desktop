class FormWithoutModelWindow < MasterWindow
  js_properties :title => "Form without a model"

  def default_config
    {
      :name         => "Form without a model",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "FormWithoutModel",
        	          :header => false, :border => true
                       }]
    }
  end

end
