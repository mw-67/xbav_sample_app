require 'rails_helper'

RSpec.describe ContractorsController, type: :controller do
  describe 'permitted params' do
    let(:params) { { 'first_name' => 'x', 'last_name' => 'y', 'partner_company_id' => 1 } }
    let(:other) { { 'bla' => 'blub' } }

    it 'permitts names and parnter_company_id only' do
      controller.params = { contractor: params.merge(other) }
      expect(controller.send(:permitted_params)).to eq(params)
    end
  end

  describe 'scopes' do
    let!(:contractor1) { create(:contractor) }
    let!(:contractor2) { create(:contractor) }
    let!(:client) { create(:client) }
    let!(:employee) { create(:employee) }

    before :each do
      sign_in
      contractor2.clients << client
      employee.clients << client
    end

    it 'returns all emploeyees without parameters' do
      get :index
      expect(assigns['collection'].size).to eq 2
    end

    it 'returns all contractors for the parnter_company only when scoped to partner_company' do
      get :index, params: { partner_company_id: contractor1.partner_company_id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [contractor1]
    end

    it 'returns all contractors for the company only when scoped to company' do
      get :index, params: { company_id: employee.company_id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [contractor2]
    end
  end
end
