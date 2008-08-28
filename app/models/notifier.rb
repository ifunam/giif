class Notifier < ActionMailer::Base
 #  def confirm(sent_at = Time.now)
#     @subject    = 'Solicitud de Orden de Compra enviada!'
#   #  @body["Notifier"]       = notifier
#     @recipients = 'fereyji@gmail.com'
#     @from       = 'fereyji@gmail.com'
#     @sent_on    = sent_at
#   end

  def order_request(order)
    @subject    = 'Solicitud de Orden de Compra'
    @recipients = 'fereyji@gmail.com'
    @from       = 'fereyji@gmail.com'
    @sent_on    = Time.now
    @body = { :order => order}
  end
end
