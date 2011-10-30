class BookGridWithDefaultValuesWindow < MasterWindow
  js_properties :title => "Book with default values"

  def default_config
    {
      :name         => "Book with default values",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "book",
      :items        => [{
                          :class_name => "BookGridWithDefaultValues",
        	          :header => false, :border => true
                       }]
    }
  end

end
