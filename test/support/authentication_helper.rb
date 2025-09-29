module AuthenticationHelpers
  def sign_in_as(user)

    visit new_session_url


    assert_selector "h1", text: "Sign in"

    fill_in "Correo electrónico", with: user.email_address
    fill_in "Password", with: "password"


    click_on "Sign in"


    assert_text "Inicio de sesión exitoso."
  end
end