class InfrastructureLayout < Netzke::Basepack::BorderLayoutPanel

  include InfrastructureLayoutHelper

  def configuration
    super.merge(
      :header => false,
      :items => [ 
        {
          :name => "details",
          :class_name => "Netzke::Basepack::Panel",
          :region => :east,
          :title  => "Details",
          :width => 250,
          :split => true
        },
        {
          :name => "infrastructure",
          :class_name => "InfrastructureTree",
          :region => :center,
          :title => "Infrastructure",
        }
      ]
    )
  end

  endpoint :select_item do |params|
    # store selected location id in the session for this component's instance
    component_session[:item_type] = params[:item_type]
    component_session[:item_id]   = params[:item_id]
   
    # selected node
    unless params[:item_type].nil?
      item = case params[:item_type]
               when 'node'
                 Node.find(params[:item_id])
               when 'tree'
                 Infrastructure.find(params[:item_id])
               else
                 Node.find(params[:item_id])
             end
    end

    {
      :details => {:update_body_html => params[:item_type] == 'node' ? node_info_html(item) : infrastructure_info_html(item), :set_title => "#{item.label} details"}
    }
  end
 
  def infrastructure_details(item)
    infrastructure_info_html(item)
  end

  def node_details(item)
    node_info_html(item)
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);
  
      // setting the 'rowclick' event
      this.getChildComponent('infrastructure').on('click', this.onItemSelectionChanged, this);
    }
  JS
  
  # Event handler
  js_method :on_item_selection_changed, <<-JS
    function(self, rowIndex){
      var tree_object = self.id.split("-");
      var item_type = tree_object[0];
      var item_id   = tree_object[1];
      this.selectItem({item_id: item_id, item_type: item_type});
    }
  JS
end
