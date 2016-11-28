# Load the Rails application.
require_relative 'application'
require 'carrierwave/orm/activerecord'
require 'bootstrap-datepicker-rails'
require 'mini_magick'
require 'date_validator'
require "sidekiq"

# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.delivery_method = :smtp

# config.action_mailer.smtp_settings = {
# 	:user_name => ENV["sendgrid_username"],
# 	:password => ENV["sendgrid_password"],
# 	:domain => "gmail.com",
# 	address => "smtp.sendgrid.net",
# 	:port => 587,
# 	:authentication => "plain",
# 	:enable_starttls_auto => true
# }


config.action_mailer.smtp_settings = {
    :address  => "smtp.gmail.com",
    :port     => 587,
    :user_name  => ENV["gmail_username"],
    :password   => ENV["gmail_password"],
    :authentication => "plain",
    :enable_starttls_auto => true
}