module ComponentOverride
  
  # Overriding this to allow for dynamically declared components
  def components
    stored_windows.inject({}){ |r, window| r.merge(window[:name].to_sym => window.reverse_merge(:prevent_header => true, :lazy_loading => true, :border => false)) }
  end

  def deliver_component_endpoint(params)
    if params[:component].present?
      puts "Rendering special component"

      cmp_name = params[:name]
      cmp_index = cmp_name.sub("cmp", "").to_i

      current_windows = stored_windows

      # we need to instantiate the newly added child to get access to its title
      cmp_class = constantize_class_name(params[:component])
      raise RuntimeError, "Could not find class #{params[:component]}" if cmp_class.nil?

      cmp_config = {:name => params[:name], :class_name => cmp_class.name}.merge(params[:config] || {}).symbolize_keys
      cmp_instance = cmp_class.new(cmp_config, self)
      
      # here we set the title
      new_window_short_config = cmp_config.merge(:title => cmp_instance.js_config[:title] || cmp_instance.class.js_properties[:title])

      current_windows << new_window_short_config
      component_session[:items] = current_windows
  
      # reset cache
      @stored_window = nil
    else
      puts "Rendering regular component"
    end
    
    super(params)
  end

  
  private

  def stored_windows
    @stored_windows ||= component_session[:items].nil? ? [{:name => 'cmp0', :title => "Window", :prevent_header => false, :closable => true, :lazy_loading => false, :class_name => "Netzke::Basepack::Window"}] : component_session[:items]
  end

end
