require 'smtp_tls'

#Action Mailer configuration for use Gmail as SMTP server
  if RAILS_ENV != 'test'
    begin
      mail_settings = YAML.load(File.read("#{RAILS_ROOT}/config/mail.yml"))
      ActionMailer::Base.delivery_method = mail_settings['method'].to_sym
      ActionMailer::Base.default_charset = mail_settings['charset']
      ActionMailer::Base.smtp_settings = mail_settings['settings']
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.raise_delivery_errors = true
    rescue
      # Fall back to using sendmail by default
      ActionMailer::Base.delivery_method = :sendmail
    end
  end
