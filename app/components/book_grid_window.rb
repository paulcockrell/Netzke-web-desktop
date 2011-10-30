class BookGridWindow < MasterWindow
  js_properties :title => "Book grid"

  def default_config
    {
      :name         => "Book grid",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => "book",
      :items        => [{
                          :class_name => "BookGrid",
        	          :header => false, :border => true
                       }]
    }
  end

end
