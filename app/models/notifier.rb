class Notifier < ActionMailer::Base
  # TODO: Change the domain and the email address to use accounts based on 
  #       yaml file, under RAILS_ROOT/config.
  def order_request_from_user(order)
    user_profile = user_profile(order.user.login)
    @subject         = '[GIIF] Solicitud de orden de compra enviada'
    @recipients     = user_profile.email
    @from             = 'noreply@fisica.unam.mx'
    @sent_on        = Time.now
    @body             = { :order => order}
    Notifier.deliver_order_to_userincharge(order, user_profile.user_incharge.email) if user_profile.has_user_incharge?
  end


  def order_to_userincharge(order, email)
    @subject         = '[GIIF] Solicitud de aprobación de orden de compra'
    @recipients     = email
    @from             = 'noreply@fisica.unam.mx'
    @sent_on        = Time.now
    @body             = { :order => order}
  end

  def request_approved(order)
    @subject          = '[GIIF] Aprobación de solicitud interna de compra'
    @recipients      = user_email(order.user.login)
    @from              = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body              = { :order => order}
  end

  def order_request_rejected(order, user_profile)
    @subject          = '[GIIF] Rechazo de solicitud interna de compra'
    @recipients      =  user_email(order.user.login)
    @from              = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body              = { :order => order}
  end
  private

  def user_email(login)
    user_profile(login).email
  end
  
  def user_profile(login)
    UserProfileClient.find_by_login(login)
  end
end
