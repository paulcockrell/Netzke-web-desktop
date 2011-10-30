class LockableUserFormWindow < MasterWindow
  js_properties :title => "Lockable user form"

  def default_config
    {
      :name         => "Locable user form",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "LockableUserForm",
        	          :header => false, :border => true
                       }]
    }
  end

end
