class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    Current.user
  end
  helper_method :current_user

  def user_not_authorized
    flash[:alert] = "No tienes permiso para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end
end
