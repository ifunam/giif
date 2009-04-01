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
      if (title=='Enviar solicitud' or title=="Aprobar" or title=="Cambiar divisa" )
        link_to_remote(image_tag(image_name, :title => title), options) 
      else 
        link_to(image_tag(image_name, :title => title), options) 
      end
    end
  end

  def activate_links(backend, status)
    if backend == "estimate"
      case status
      when "solicitud_no_enviada" : [true, true]
      else [false, false]
      end
    elsif backend == "order" 
      case status
      when "solicitud_no_enviada" : [true, true, true, true, true]
      else [false, false, true, true, false]
      end
    elsif backend == "budget" 
      case status
      when "presupuesto_en_progreso" : [true, false, false, true, true, true, true, true]
      else [false, false, false, false, false, false, true, true]
      end
    elsif backend == "acquisition" 
      case status
      when "adquisición_en_progreso" : [true, false, true, true, false]
      else [false, false, true, true, false]
      end
    end
  end

end
