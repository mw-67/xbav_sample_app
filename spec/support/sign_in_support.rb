module SignInSupport
  def sign_in(user_email = 'foo@bar.de')
    session[:user] = user_email
  end

  def sign_out
    session[:user] = nil
  end
end
