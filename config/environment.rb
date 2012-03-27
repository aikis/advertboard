# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Testapp::Application.initialize!

# Credentials for Gmail
Testapp::Application.configure do
  require 'tlsmail'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  
    :address            => 'smtp.gmail.com',
    :port               => 587,
    :tls                  => true,
    :domain             => 'gmail.com',
    :authentication     => :plain,
    :user_name          => 'aikismax@gmail.com',
    :password           => 'Aikis13151725#@&#)%@'
  }
end