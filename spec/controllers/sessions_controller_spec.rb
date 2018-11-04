require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'create' do
    before :each do
      request.env['omniauth.auth'] = { 'info' => { 'email' => 'foo@bar.de' } }
    end
    it 'sets the user in the session' do
      get :create, params: { provider: 'github' }
      expect(session[:user]).to eq 'foo@bar.de'
    end
  end

  describe 'destroy' do
    before :each do
      sign_in
    end

    it 'clears the user from the session' do
      delete :destroy
      expect(session[:user]).to be nil
    end

    it 'redirects to root' do
      delete :destroy
      expect(response).to be_redirect
      expect(response.redirect_url).to eq 'http://test.host/'
    end
  end
end
