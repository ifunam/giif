require 'rubygems'
require 'pdf/writer'
require 'iconv'
class DocumentGenerator
  attr_accessor :data

  def initialize(data, user_profile)
    @data = data
    @user = user_profile
  end

  def to_pdf
    pdf = PDF::Writer.new

    pdf.image "public/images/Compras.jpg", :pad => 0, :width => 497, :justification => :center #insert template

    #user data
    pdf.add_text(478, 692, @data.id.to_s, 10)                                              #folio???
    pdf.add_text(468, 671, date_string, 10)                                                  #date
    pdf.add_text(165, 672, to_iso(@user.adscription_name), 10)                  #adscription
    pdf.add_text(165, 647, to_iso(@user.fullname), 10)                                #name
    pdf.add_text(165, 628, @user.phone, 10)                                               #telephone

    #order product(s)  --space between rows: 19, max rows: 10
    i=0
    @data.order_products.each do |product|
      i += 1
      pdf.add_text(85, 608 - 19*i, i, 10)                                                        #numeric order
      pdf.add_text(115, 608 - 19*i, product.quantity, 10)                             #quantity
      pdf.add_text(150, 608 - 19*i, to_iso(product.description), 10 )            #description
      pdf.add_text(385, 608 - 19*i, "unit", 10)                                              #unit??
      pdf.add_text(415, 608 - 19*i, product.price_per_unit, 10)                    #price
      pdf.add_text(477, 608 - 19*i, product.quantity*product.price_per_unit, 10)               #import
    end
    pdf.add_text(477, 404, @data.calculate_total_amount, 10)                    #total


    #order_providers --space between rows: 13, max rows: 3
    j=0
    @data.providers.each do |provider|
      j += 1
      pdf.add_text(85, 388 - 13*j, j, 10)                                                        #numeric order
      pdf.add_text(115, 388 - 13*j, to_iso(provider.name), 10)                    #name
    end

    #order file
      pdf.add_text(get_x(@data.order_file.file_type_id), 322, "X", 10)                                #type
    #agregar descripcion de otro

    #order project
      pdf.add_text(get_x(@data.project.project_type_id), get_y(@data.project.project_type_id), "X", 10)           #type
      pdf.add_text(185, 269, to_iso(@data.project.name), 10)                         #name
      pdf.add_text(471, 255, @data.project.key, 10)                                       #key
    #agregar descripcion de otro


    pdf.save_as("tmp/documents/solicitud_compra_" + @data.id.to_s + ".pdf")
  end

#   def acquisition_data
#     #currency
#     pdf.add_text(120, 216, to_iso(@data.currency_order.currency.name), 8)               #currency
#     pdf.add_text(265, 217, @data.currency_order.value, 8)                                          #exchange rate
#     pdf.add_text(475, 217, @data.calculate_total * @data.currency_order.value, 8)      #equivalency of total in pesos
#   end

  private
  def date_string
    date = @data.date.strftime("%d      %m       %y")
  end

  def get_x(id)
      case id
      when 1|5 : "150"
      when 2    : "222"
      when 3    : "306"
      when 4    : "387"
      end
  end

  def get_y(id)
    if id==5
      "285"
    else
      "295"
    end
  end

  def to_iso(texto)
    c = Iconv.new('ISO-8859-15//IGNORE//TRANSLIT', 'UTF-8')
    iso = c.iconv(texto)
  end

end
