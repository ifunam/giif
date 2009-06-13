module OrderHelper
  def get_coordinated_for_x(x)
    ["150", "222", "306", "387", "150"][x.to_i - 1]
  end

  def get_coordinated_for_y(y)
    y == 5 ? "285" : "295"
  end

  def links_for_actions(controller_name, record)
    Controller.find_by_name(controller_name).permissions.find(:all, :conditions => ['order_status_id = ?', record.order_status_id], :order => 'id').collect do |p|

      if p.is_remote?
        link_to_remote(icon_tag(p), :url => {:action => p.action, :id => record.id}, :format => 'js', 
                       :loading => loading_indicator(record.id), 
                       :complete => loading_complete(record.id))
      elsif !p.format.nil? and p.format == 'pdf'
        link_to(icon_tag(p), {:action => p.action, :id => record.id, :format => 'pdf'}, :method =>  p.method.to_sym)
      else
        link_to(icon_tag(p), {:action => p.action, :id => record.id}, :method => p.method.to_sym, :confirm => p.message)
      end
    end.join(' ')
  end

  def icon_tag(permission)
    icon_name= "icon_#{permission.action}.png"
    image_tag(icon_name, :title => permission.title)
  end
  
  def loading_indicator(id)
    "$('record_#{id}_loader_indicator').show();"
  end

  def loading_complete(id)
    "$('record_#{id}_loader_indicator').hide();"
end

  def set_row_class(partial_counter)
    'row_' + ((partial_counter + 1) % 2).to_s
  end
  
  def status_image_tag(order)
    image_tag("status_"+order.current_status.downcase.split(/\s+/).join('_')+".jpg")
  end
end
