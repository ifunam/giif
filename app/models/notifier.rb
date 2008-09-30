class Notifier < ActionMailer::Base
 #  def confirm(sent_at = Time.now)
#     @subject    = 'Solicitud de Orden de Compra enviada!'
#   #  @body["Notifier"]       = notifier
#     @recipients = 'fereyji@gmail.com'
#     @from       = 'fereyji@gmail.com'
#     @sent_on    = sent_at
#   end

  def order_request(order, user_profile)
    @subject    = 'Solicitud de Orden de Compra'
    emails = [ user_profile.email ]
    emails << user_profile.user_incharge.email if user_profile.has_user_incharge?
    @recipients = emails.join(', ')
    @from       = 'noreply@fisica.unam.mx'
    @sent_on    = Time.now
    @body = { :order => order}
  end
end
