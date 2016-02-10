require "application_responder"

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  self.responder = ApplicationResponder
  respond_to :json
  
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
end
