class BookFormWindow < MasterWindow
  js_properties :title => "Book form"

  def default_config
    {
      :name         => "Book form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "BookForm",
        	          :header => false, :border => true
                       }]
    }
  end

end
