class BooksBoundToAuthorWindow < MasterWindow
  js_properties :title => "Books bound to author"

  def default_config
    {
      :name         => "Book bound to author",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "book",
      :items        => [{
                          :class_name => "BooksBoundToAuthor",
        	          :header => false, :border => true
                       }]
    }
  end

end
