RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.load_paths += %W( #{RAILS_ROOT}/clients #{RAILS_ROOT}/lib)
  config.time_zone = 'Mexico City'
  config.active_record.observers = :order_observer, :order_file_observer if RAILS_ENV != 'test'

  config.action_mailer.register_template_extension('haml')
  config.action_mailer.delivery_method = :sendmail
  sendmail_config = YAML.load_file(RAILS_ROOT + "/config/mail.yml")
  config.action_mailer.sendmail_settings = sendmail_config['settings']
  config.action_controller.session = {
      :session_key => '_giif_session',
      :secret      => 'ee096182965846b40741c6376946a30b05546bf91481c6105ec5cfa7ec760a7fcc86f240effc422b7a16e17d3d0c21c0bf2266f8ca73624ff4ffa8a3390b34bb'
  }
end
