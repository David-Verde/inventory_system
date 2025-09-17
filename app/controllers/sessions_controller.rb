
class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(email_address: params[:user][:email_address], password: params[:user][:password])
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Inicio de sesión exitoso."
    else
      redirect_to new_session_path, alert: "Correo o contraseña incorrectos."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Has cerrado la sesión."
  end
end
