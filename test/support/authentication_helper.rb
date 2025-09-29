module AuthenticationHelpers

  def sign_in_as(user)
    visit new_session_url
    fill_in "Correo electrónico", with: user.email_address
    fill_in "Password", with: "password"
    click_on "Sign in"
    assert_text "Inicio de sesión exitoso."
  end

  def login_as(user)
    post session_path, params: {
      user: {
        email_address: user.email_address,
        password: "password"
      }
    }
  end
end