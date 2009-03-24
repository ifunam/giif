module OrderHelper
  def get_coordinated_for_x(x)
    ["150", "222", "306", "387", "150"][x.to_i - 1]
  end

  def get_coordinated_for_y(y)
    y == 5 ? "285" : "295"
  end

  def link_to_status(status, title, image_name, options={})
    case status
    when false then image_tag(image_name, :title => title)
    when true  then
      if title=='Enviar solicitud'
        link_to_remote(image_tag(image_name, :title => title), options) 
      else 
        link_to(image_tag(image_name, :title => title), options) 
      end
    end
  end

  def activate_links(order_status)
    case order_status
    when 1 then [true, true, true, true, true]
    when 3 then [false, false, true, true, false]
    end
  end
end
