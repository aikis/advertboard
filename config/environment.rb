# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Testapp::Application.initialize!

# Credentials for Gmail
# Need to generate 2-step auth GMail account first!
Testapp::Application.configure do
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default :charset => "utf-8"
  ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "username@gmail.com",
  :password             => 'secret',
  :authentication       => "plain",
  :enable_starttls_auto => true
  }
end