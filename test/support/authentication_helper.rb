module AuthenticationHelpers

  def sign_in_as(user)
    visit new_session_path
    fill_in "Correo electrónico", with: user.email_address
    fill_in "Password", with: 'password'
    click_on "Sign in"
  end


  def login_as(user, password: "password")
    post session_path, params: {
      user: {
        email_address: user.email_address,
        password: password
      }
    }
  end

  def logout
    delete session_path
  end
end