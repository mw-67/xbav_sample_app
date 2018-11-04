require 'rails_helper'

describe CompaniesController do # use companies controller as a sample for shared controller

  it 'requires signin' do
    get :index
    expect(response).to be_redirect
    expect(response.redirect_url).to eq "http://test.host/auth/github"
  end

  describe 'signed in' do
    let(:user) { 'foo@bar.de' }
    let!(:company) { create(:company) }

    before :each do
      sign_in user
    end

    describe 'list' do
      it 'returns ok' do
        get :index
        expect(response).to be_ok
      end

      it 'provides a list of companies' do
        get :index
        expect(assigns['collection']).to eq [company]
      end
    end

    describe 'show' do
      it 'returns ok' do
        get :show, params: { id: company.id }
        expect(response).to be_ok
      end

      it 'provides the company' do
        get :show, params: { id: company.id }
        expect(assigns['instance']).to eq company
      end
    end

    describe 'new' do
      it 'returns ok' do
        get :new
        expect(response).to be_ok
      end

      it 'provides a new company' do
        get :new
        expect(assigns['instance']).to be_a Company
        expect(assigns['instance']).not_to be_persisted
      end
    end

    describe 'create' do
      let(:new_company) { Company.last }

      it 'creates the company' do
        expect { post :create, params: { company: { name: 'fizz' } } }.to change { Company.count}.by(1)
        expect(new_company.name).to eq 'fizz'
      end

      it 'redirects after creation' do
        post :create, params: { company: { name: 'fizz' } }
        expect(response).to be_redirect
        expect(response.redirect_url).to eq 'http://test.host/companies/' + new_company.id.to_s
      end

      it 'creates no company on validation error' do
        expect { post :create, params: { company: { name: '' } } }.not_to change { Company.count}
      end

      it 'renders on validation error providing errors' do
        post :create, params: { company: { name: '' } }
        expect(response).to be_ok
        expect(assigns['instance'].errors).not_to be_empty
      end
    end

    describe 'update' do
      it 'updates the company' do
        put :update, params: { id: company.id, company: { name: 'buzz' } }
        expect(company.reload.name).to eq 'buzz'
      end

      it 'redirects after update' do
        put :update, params: { id: company.id, company: { name: 'buzz' } }
        expect(response).to be_redirect
        expect(response.redirect_url).to eq 'http://test.host/companies/' + company.id.to_s
      end

      it 'renders on validation error providing errors' do
        put :update, params: { id: company.id, company: { name: '' } }
        expect(response).to be_ok
        expect(assigns['instance'].errors).not_to be_empty
      end
    end

    describe 'delete' do
      it 'deletes the company' do
        expect { delete :destroy, params: { id: company.id } }.to change { Company.count}.by(-1)
        expect(Company.find_by(id: company.id)).to be nil
      end

      it 'redirects to list' do
        delete :destroy, params: { id: company.id }
        expect(response).to be_redirect
        expect(response.redirect_url).to eq 'http://test.host/companies'
      end

      describe 'when object cannot be deleted' do
        let!(:employee) { create(:employee, company: company) }

        it 'does not delete the company' do
        expect { delete :destroy, params: { id: company.id } }.not_to change { Company.count}
        expect(Company.find_by(id: company.id)).to eq company
        end

        it 'provides a flash and redirects to show' do
          delete :destroy, params: { id: company.id }
          expect(response).to be_redirect
          expect(response.redirect_url).to eq 'http://test.host/companies/' + company.id.to_s
          expect(flash[:alert]).to eq 'cannot delete. fix dependecies first.'
        end
      end
    end
  end
end
