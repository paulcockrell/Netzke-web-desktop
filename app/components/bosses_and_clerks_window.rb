class BossesAndClerksWindow < MasterWindow
  js_properties :title => "Boss and clerks!"

  def default_config
    {
      :name         => "Bosses and clerks",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "bosses_and_clerks",
      :items        => [{
                          :class_name => "BossesAndClerks",
        	          :header => false, :border => true
                       }]
    }
  end

end
