module AuthenticationHelper

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