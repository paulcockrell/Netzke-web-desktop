class MasterWindow < Netzke::Basepack::Window
  
  js_mixin :master_window
  
  js_properties :close_action => "close",
                :is_minimized => false,
                :constrain    => true,
                :render_to    => "main-panel",
                :associated_button => "",
                :in_work_space => 1,
                :animate_target => "app__application_menu",
                :org_animate_target => "app__application_menu",
                :anim_show_cfg => {
                    :duration => 2
                },
                :desktop_icon_cls  => "tag_blue",
                :desktop_icon_top  => "50",
                :desktop_icon_left => "50"


end
