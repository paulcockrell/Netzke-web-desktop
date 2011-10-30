class BookGridWithVirtualAttributesWindow < MasterWindow
  js_properties :title => "Book grid with virtual attributes"

  def default_config
    {
      :name         => "Book grid with virtual attributes",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "BookGridWithVirtualAttributes",
        	          :header => false, :border => true
                       }]
    }
  end

end
