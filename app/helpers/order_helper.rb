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

  def activate_links(backend_status)
    case backend_status
    when "order_sin_enviar" then [true, true, true, true, true]
#     when "order_en_proceso" then [true, true, true, true, true]     
#     when "order_aprobado" then [true, true, true, true, true]     
#     when "order_rechazado" then [true, true, true, true, true]     
#     when "order_transferencia" then [true, true, true, true, true]     
    when "budget_en_proceso" then [true, false, true, true, true, true, true, false]
    when "budget_aprobado" then [false, false, false, false, false, false, true, true]
#     when "budget_rechazado" then [true, true, true, true, true]     
#     when "budget_transferencia" then [true, true, true, true, true]     
    when "acquisition_aprobado" then [true, false, true, false, false]
    end
  end

end
