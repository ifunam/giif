# encoding: utf-8
#
class Notifier < ActionMailer::Base
  # TODO: Change the domain and the email address to use accounts based on 
  #       yaml file, under RAILS_ROOT/config.
  def estimate_request_from_user(order)
    user_profile     = user_profile(order.user.login)
    @subject         = '[GIIF] Solicitud de cotización enviada'
    @recipients      = 'fereyji@gmail.com' #user_profile.email
    @from            = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body            = { :order => order}
    order.providers.each do |provider|
      Notifier.deliver_estimate_to_provider(order, provider)
    end
  end

  def estimate_to_provider(order, provider)
    user_profile = user_profile(order.user.login)
    @subject         = '[GIIF] Solicitud de cotización del IFUNAM'
    @recipients      = 'fereyji@gmail.com' #provider.email
    @from            = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body            = { :order => order, :provider => provider }
  end

  def estimate_response_from_provider(order, provider)
    user_profile = user_profile(order.user.login)
    @subject         = '[GIIF] Solicitud de cotización respondida'
    @recipients      = 'fereyji@gmail.com' #provider.email
    @from            = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body            = { :order => order, :provider => provider }
  end

  def order_request_from_user(order)
    user_profile     = user_profile(order.user.login)
    @subject         = '[GIIF] Solicitud de orden de compra enviada'
    @recipients      = 'fereyji@gmail.com' #user_profile.email
    @from            = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body            = { :order => order}
    Notifier.deliver_order_to_userincharge(order, user_profile.user_incharge.email) if user_profile.has_user_incharge?
  end


  def order_to_userincharge(order, email)
    @subject         = '[GIIF] Solicitud de aprobación de orden de compra'
    @recipients      = 'fereyji@gmail.com' #email
    @from            = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body            = { :order => order}
  end

  def request_approved(order)
    @subject          = '[GIIF] Aprobación de solicitud interna de compra'
    @recipients       = 'fereyji@gmail.com' #user_email(order.user.login)
    @from             = 'noreply@fisica.unam.mx'
    @sent_on          = Time.now
    @body             = { :order => order}
  end

  def order_request_rejected(order)
    @subject          = '[GIIF] Rechazo de solicitud interna de compra'
    @recipients       = user_email(order.user.login)
    @from             = 'noreply@fisica.unam.mx'
    @sent_on          = Time.now
    @body             = { :order => order}
  end
  private

  def user_email(login)
    user_profile(login).email
  end
  
  def user_profile(login)
    UserProfileClient.find_by_login(login)
  end
end
