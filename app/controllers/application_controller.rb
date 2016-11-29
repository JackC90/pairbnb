class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :verify_authenticity_token
  # before_filter :authenticate

  # def authenticate
  # 	redirect_to facebook_sign_in_path unless User.find_by_provider_and_uid(auth["provider"], auth["uid"])
  # end
end
