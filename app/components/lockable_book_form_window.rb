class LockableBookFormWindow < MasterWindow
  js_properties :title => "Lockable book form"

  def default_config
    {
      :name         => "Locable book form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "LockableBookForm",
        	          :header => false, :border => true
                       }]
    }
  end

end
