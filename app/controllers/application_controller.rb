class ApplicationController < ActionController::Base

  private

  def authenticate_user!
    return if ENV['SKIP_AUTHENTICATION']
    redirect_to '/auth/github' unless current_user.present?
  end
end
