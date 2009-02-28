require 'user_profile_client'
class OrderReporter
    # Based on Template Design Pattern
    # * Separate out the things that change from those that stay the same *,
    # For example: Don't use specific formats for this info
    #
    # The basic flow of this class remains the same on:
    #
    # 1. Output any header information required by the specific format
    # 2. Output the title  (title, date, etc)
    # 3. Output the user information
    # 4. Output the body information with one line per item: products, providers, et.al
    # 5. Output footer (Author, Ip Address, Hour and time, et all.)

    def self.find_by_order_id(id)
       @object = new(Order.find(id))
       @object
    end

    def initialize(order)
      @order = order
      @user_profile = UserProfileClient.find_by_login(order.user.login)
    end

    def order_id
      @order.id.to_s
    end

    def order_date
      @order.date.to_s(:long)
    end

    def remote_ip_address
      # TODO: Add column for ip_address into orders table
      @order.ip_address
    end

    def user_login
      @user_profile.login
    end

    def user_email
      @user_profile.email
    end

    def user_fullname
      @user_profile.fullname
    end

    def user_adscription_name
      @user_profile.adscription_name
    end

    def user_phone
      @user_profile.phone
    end

    def user_has_academic_responsible?
      @user_profile.has_user_incharge? 
    end

    def academic_responsible_fullname
      @user_profile.user_incharge.fullname if user_has_academic_responsible?
    end

    def products
      @order.order_products
    end

    def providers
      @order.providers
    end

    def attachments
      @order.order_files
    end

    def project
      @order.project
    end

    def currency
      @order.currency_order
    end

    # TODO: Review this methods, You should consider to Delegate those methods to some class or module called Formatter
    def header
      ['Orden de compra No.', order_id, 'de', user_fullname, 'enviada el', order_date].join(' ')
    end

    def name
      ['orden_de_compra', user_login, order_id].join('_')
    end

    def footer
      ip_address =  !remote_ip_address.nil? ? "from #{remote_ip_address}," : ''
      ['Giif - Inst. Fís., UNAM,', user_login, ip_address, (Time.now.to_s :long)].join(' ')
    end
end
