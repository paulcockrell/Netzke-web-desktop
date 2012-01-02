class AdvancedWindowTree < Netzke::Basepack::Tree
  
  NODES_TO_ICONS_MAP = {
      'unknown'    => 'images/icons/question.png',
      'failed jobs'=> 'images/icons/smiley_cry.png',
      'completed jobs'=> 'images/icons/smiley_lol.png',
      'job'        => 'images/icons/traffic_cone.png'
  }

  def configuration
    super.merge(
      :title => "Jobs",
      :model => "Infrastructure"
    )
  end
  
  def node_icon(node_type=nil)
    node_type.nil? ? NODES_TO_ICONS_MAP['unknown'] : NODES_TO_ICONS_MAP[node_type]
  end

  def device_icon(device)
    return 'images/icons/computer.png' if item.nil?
  end

  endpoint :get_children do |params|
    massage_params(params)
    klass = config[:model].constantize
    parent = params[:node] == 'source' ? klass.where("parent_id is NULL").first : klass.find(params[:node].to_i)

    return {} if parent.nil?
    children = (parent.children + parent.jobs).map do |n|
      is_a_job = n.respond_to?('parent') ? false : true
      {:text => n.label,
       :id   => is_a_job ? "node-#{n.id}" : "tree-#{n.id}",
       :leaf => is_a_job ? true : is_a_leaf(n),
       :icon => node_icon(is_a_job ? 'job' : n.label.downcase)}
    end

    children
  end

  
  private

  def massage_params(params)
    params[:node] = params[:node].gsub("tree-","") if params[:node]
  end
end
