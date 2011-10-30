class App < Netzke::Basepack::SimpleApp
  include ComponentOverride

  # CSS 
  css_include :main, :windows, :desktop_icons

  # Javascript properties and mixins
  js_property :border, false
  js_mixin :main, :app, :window_manager, :work_space_manager, :desktop_icon, :desktop_icon_manager, :statusbar_button_manager, :stores
  
  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);
      console.log("Initializing workspace");
      this.window_components = [1];
    }
  JS
  
  # load anonymous instance of a component
  js_method :load_window, <<-JS
    function(opts) {
      component = opts.name.toTitleCase();
      this.loadChild(component, { newWindow: true });
    }
  JS

  # Main configuration for App
  def configuration
    sup = super
    sup.merge(
      :items => [main_panel_config(main_panel_options), status_bar_config(status_bar_options), menu_bar_config]
    )
  end

  # Main panel options
  def main_panel_options
    {
      :cls => 'desktop'
    }
  end

  # Status bar options
  def status_bar_options
    {
     :height => 28,
     :default_text => "",
     :default_icon_cls => "x-status-ready",
     :busyText => '',
     :busyIconCls => "x-status-busy"
    }
  end

  # Main menu options
  def menu
    [
      {
        :text => 'Applications',
        :id   => 'app__application_menu',
        :icon => 'images/icons/applications_blue.png',
        :menu => [{
          :text => 'Users',
          :id   => 'app__users_menu',
          :icon => 'images/icons/computer.png',
          :menu => [{
            :text => 'Infrastructure',
            :id   => 'app__infrastructure_menu',
            :icon => 'images/icons/computer.png',
            :menu => [:author_window.action,
                      :user_grid_window.action,
                      :generic_user_form_window.action,
                      :lockable_user_form_window.action,
                      :user_form_window.action,
                      :user_form_with_default_fields_window.action,
                      :user_grid_with_customized_form_fields_window.action]
            },
            {
            :text => 'Devices',
            :id   => 'app__devices_menu',
            :icon => 'images/icons/computer.png',
            :menu => [:user_grid_window.action,
                      :user_grid_window.action]
            }
          ]
          },{
            :text => 'Book',
            :id   => 'app__book_menu',
            :icon => 'images/icopns/book.png',
            :menu => [:book_form_window.action,
                      :book_form_with_custom_fields_window.action,
                      :book_grid_window.action,
                      :book_grid_with_default_values_window.action,
                      :book_grid_with_nested_attributes_window.action,
                      :book_grid_with_virtual_attributes_window.action,
                      :book_paging_form_panel_window.action,
                      :books_bound_to_author_window.action,
                      :lockable_book_form_window.action]
          },{
            :text => 'Misc',
            :id   => 'app__miscellaneous_menu',
            :icon => 'images/icons/gear.png',
            :menu => [:form_without_model_window.action,
                      :simple_accordion_window.action,
                      :simple_panel_window.action,
                      :simple_tab_panel_window.action]
        }]
      },{
        :text => 'Help',
        :id   => 'app__system_menu',
        :icon => 'images/icons/wrench.png',
        :menu => [:about_window.action]
      },'->',{
        :id => 'app__work_space_one',
        :iconCls => 'inactive',
        :handler => :show_work_space_one
      },{
        :id => 'app__work_space_two',
        :iconCls => 'inactive',
        :handler => :show_work_space_two
      },{
        :id => 'app__work_space_three',
        :iconCls => 'inactive',
        :handler => :show_work_space_three
      },{
        :id => 'app__work_space_four',
        :iconCls => 'inactive',
        :handler => :show_work_space_four
      },{
        :xtype => 'tbseparator'
      },{
        :id    => 'app__user_menu',
        :icon  => 'images/icons/plug_disconnect.png',
        :menu  => [{
          :text => 'Logout',
          :icon => 'images/icons/door_open_out.png',
          :handler => :do_nothing
        }]
      }
    ] + super
  end

  # Component actions
  action :user_grid_window,
         :icon => :users,
         :isDesktopable => true,
         :text => "Users",
         :handler => :load_window

  action :bosses_and_clerks_window,
         :icon => :user_business,
         :isDesktopable => true,
         :text => "Bosses & clerks",
         :handler => :load_window

  action :author_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Authors",
         :handler => :load_window

  action :book_form_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book form",
         :handler => :load_window

  action :book_form_with_custom_fields_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book form custom fields",
         :handler => :load_window

  action :book_form_with_nested_attributes_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book form nested attributes",
         :handler => :load_window

  action :book_grid_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book grid",
         :handler => :load_window

  action :book_grid_with_default_values_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book grid default values",
         :handler => :load_window

  action :book_grid_with_nested_attributes_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book grid nested attributes",
         :handler => :load_window

  action :book_grid_with_virtual_attributes_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book grid virtual attributes",
         :handler => :load_window

  action :book_paging_form_panel_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Book paging form panel",
         :handler => :load_window

  action :books_bound_to_author_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Books bound to author",
         :handler => :load_window

  action :form_without_model_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Form without model",
         :handler => :load_window

  action :generic_user_form_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Generic user form",
         :handler => :load_window

  action :lockable_book_form_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Locable book form",
         :handler => :load_window

  action :lockable_user_form_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Locable user form",
         :handler => :load_window

  action :simple_accordion_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Simple accordion",
         :handler => :load_window

  action :simple_panel_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Simple panel",
         :handler => :load_window

  action :simple_tab_panel_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "Simple tab panel",
         :handler => :load_window

  action :user_form_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "User form panel",
         :handler => :load_window

  action :user_form_with_default_fields_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "User form with default fields",
         :handler => :load_window

  action :user_grid_with_customized_form_fields_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "User grid with custom for fields",
         :handler => :load_window

  action :about_window,
         :icon => :question_frame,
         :isDesktopable => true,
         :text => "About",
         :handler => :load_window
  
  # Component references
  component :user_grid_window
  component :bosses_and_clerks_window
  component :author_window
  component :about_window
  component :book_form_window
  component :book_form_with_custom_fields_window  
  component :book_form_with_nested_attributes_window  
  component :book_grid_window  
  component :book_grid_with_default_values_window 
  component :book_grid_with_nested_attributes_window 
  component :book_grid_with_virtual_attributes_window 
  component :book_paging_form_panel_window 
  component :books_bound_to_author_window 
  component :form_without_model_window
  component :generic_user_form_window
  component :lockable_book_form_window
  component :lockable_user_form_window
  component :simple_accordion_window
  component :simple_panel_window
  component :simple_tab_panel_window
  component :user_form_window
  component :user_form_with_default_fields_window
  component :user_grid_with_customized_form_fields_window

end
