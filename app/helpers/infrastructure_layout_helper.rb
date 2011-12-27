module InfrastructureLayoutHelper

  def format_date(date)
    date.strftime("%a %d-%h-%G")
  end
  
  def infrastructure_info_html(inf)
    return "<h1><i>Unable to locate infrastructure item details</i></h1>" if inf.nil?
    res = "<table>"
    res << "<tr><td>Created:</td><td>#{format_date(inf.created_at)}</td></tr>" unless inf.created_at.nil?
    res << "</table>"
    res
  end

  def node_info_html(node)
    return "<h1><i>Unable to locate node details</i></h1>" if node.nil?
    res = "<table>"
    res << "<tr><td>Host name:</td><td>#{node.hostname}</td></tr>" unless node.hostname.empty?
    res << "<tr><td>Operating system:</td><td>#{node.operating_system.label}</td></tr>" unless node.operating_system.nil?
    res << "<tr><td>IP Address:</td><td>#{node.ip_address}</td></tr>" unless node.ip_address.empty?
    res << "<tr><td>Mac Address:</td><td>#{node.mac_address}</td></tr>" unless node.mac_address.empty?
    res << "<tr><td>Located at:</td><td>#{node.infrastructure.label}</td></tr>" unless node.infrastructure.nil?
    res << "<tr><td>Metrics present:</td><td>#{node.has_metrics?}</td></tr>" unless node.updated_at.nil?
    res << "<tr><td>Created:</td><td>#{format_date(node.created_at)}</td></tr>" unless node.created_at.nil?
    res << "<tr><td>Last updated:</td><td>#{format_date(node.updated_at)}</td></tr>" unless node.updated_at.nil?
    res << "</table>"
    res
  end
end
