class BookFormWithCustomFieldsWindow < MasterWindow
  js_properties :title => "Book form"

  def default_config
    {
      :name         => "Book with custom fields",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "BookFormWithCustomFields",
        	          :header => false, :border => true
                       }]
    }
  end

end
