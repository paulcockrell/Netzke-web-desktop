class AuthorWindow < MasterWindow
  js_properties :title => "Authors"

  def default_config
    {
      :name         => "Authors",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "AuthorGrid",
        	          :header => false, :border => true
                       }]
    }
  end

end
