class AdvancedApplicationWindow < MasterWindow
  js_properties :title => 'Advanced application'
  js_mixin :menu
  css_include :menu

  def default_config
    {
      :name         => 'AdvancedApplication',
      :width        => '500',
      :height       => '350',
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls     => 'icon-advanced-application-window',
      :items        => [{
                          :class_name => 'AdvancedApplicationWindowLayout',
	        	  :header     => false,
                          :border     => true,
                       }],
      :desktop_icon_cls  => 'application_xp',
      :desktop_icon_top  => '50',
      :desktop_icon_left => '50'
    }
  end
end
