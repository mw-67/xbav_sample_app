class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    session[:user] = auth['info']['email']
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
