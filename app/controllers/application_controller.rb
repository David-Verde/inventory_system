class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  private

  def current_user
    Current.user
  end
  helper_method :current_user
end
