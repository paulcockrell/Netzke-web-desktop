class BookPagingFormPanelWindow < MasterWindow
  js_properties :title => "Book paging form panel"

  def default_config
    {
      :name         => "Book paging form panel",
      :width        => 500,
      :height       => 350,
      :minimizable  => true,
      :maximizable  => true,
      :persistence  => true,
      :icon_cls      => "users",
      :items        => [{
                          :class_name => "BookPagingFormPanel",
        	          :header => false, :border => true
                       }]
    }
  end

end
