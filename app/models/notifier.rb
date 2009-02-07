class Notifier < ActionMailer::Base

  def order_request_from_user(order, user_profile)
    @subject         = '[GIIF] Solicitud de orden de compra enviada'
    @recipients     = 'fereyji@gmail.com' #user_profile.email
    @from             = 'noreply@fisica.unam.mx'
    @sent_on        = Time.now
    @body             = { :order => order}
  end

  def order_to_userincharge(order, user_incharge)
    @subject         = '[GIIF] Solicitud de aprobación de orden de compra'
    @recipients     = 'fereyji@gmail.com' #user_incharge.email #user_profile.user_incharge.email if user_profile.has_user_incharge?
    @from             = 'noreply@fisica.unam.mx'
    @sent_on        = Time.now
    @body             = { :order => order}
  end

  def request_approved(order) #, user_profile)
    @subject          = '[GIIF] Aprobación de solicitud interna de compra'
    @recipients      = 'fereyji@gmail.com' #user_profile.email
    @from              = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body              = { :order => order}
  end

  def order_request_rejected(order) #, user_profile)
    @subject          = '[GIIF] Rechazo de solicitud interna de compra'
    @recipients      = 'fereyji@gmail.com' #user_profile.email
    @from              = 'noreply@fisica.unam.mx'
    @sent_on         = Time.now
    @body              = { :order => order}
  end

end
