class InfrastructureTree < Netzke::Basepack::Tree
  
  NODES_TO_ICONS_MAP = {
      'unknown'    => 'images/icons/question.png',
      'datacenter' => 'images/icons/building.png',
      'server'     => 'images/icons/server.png',
      'computer'   => 'images/icons/computer.png',
      'laptop'     => 'images/icons/e_book_reader_white.png',
      'switch'     => 'images/icons/network_hub.png'
  }

  def configuration
    super.merge(
      :title => "Infrastructure",
      :model => "Infrastructure"
    )
  end
  
  def node_icon(node_type=nil)
    node_type.nil? ? NODES_TO_ICONS_MAP['Server'] : NODES_TO_ICONS_MAP[node_type]
  end

  def device_icon(device)
    return 'images/icons/computer.png' if item.nil?
  end

  endpoint :get_children do |params|
    massage_params(params)
    klass = config[:model].constantize
    parent = params[:node] == 'source' ? klass.where("parent_id is NULL").first : klass.find(params[:node].to_i)

    return {} if parent.nil?
    children = (parent.children + parent.nodes).map do |n|
      is_a_node = n.respond_to?('hostname') ? true : false
      {:text => is_a_node ? n.hostname : n.label,
       :id => is_a_node ? "node-#{n.id}" : "tree-#{n.id}",
       :leaf => is_a_node ? true : is_a_leaf(n),
       :icon => node_icon(is_a_node ? n.node_type.label.downcase : 'datacenter')}
    end

    children
  end

  
  private

  def massage_params(params)
    params[:node] = params[:node].gsub("tree-","") if params[:node]
  end
end
