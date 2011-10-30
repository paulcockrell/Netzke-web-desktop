class BookFormWithNestedAttributesWindow < MasterWindow
  js_properties :title => "Book with nested attrs form"

  def default_config
    {
      :name         => "Book with nested attrs form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "book",
      :items        => [{
                          :class_name => "BookFormWithNestedAttributes",
        	          :header => false, :border => true
                       }]
    }
  end

end
