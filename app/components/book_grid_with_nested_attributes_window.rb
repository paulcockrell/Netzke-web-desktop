class BookGridWithNestedAttributesWindow < MasterWindow
  js_properties :title => "Book grid nested attributes"

  def default_config
    {
      :name         => "Book grid nested attributes",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "book",
      :items        => [{
                          :class_name => "BookGridWithNestedAttributes",
        	          :header => false, :border => true
                       }]
    }
  end

end
