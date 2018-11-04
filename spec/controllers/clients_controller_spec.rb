require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  describe 'permitted params' do
    let(:params) { { 'first_name' => 'x', 'last_name' => 'y' } }
    let(:other) { { 'bla' => 'blub' } }

    it 'permitts names' do
      controller.params = { client: params.merge(other) }
      expect(controller.send(:permitted_params)).to eq(params)
    end
  end

  describe 'scopes' do
    let!(:client1) { create(:client) }
    let!(:client2) { create(:client) }
    let!(:client3) { create(:client) }
    let!(:employee) { create(:employee) }
    let!(:contractor) { create(:contractor) }
    let(:company) { employee.company }
    let(:partner_company) { contractor.partner_company }

    before :each do
      sign_in
      employee.clients << client2
      contractor.clients << client3
    end

    it 'provides all clients without restriction' do
      get :index
      expect(assigns['collection'].size).to eq 3
    end

    it 'provides the clients of a companies employees for a commpany' do
      get :index, params: { company_id: company.id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [client2]
    end

    it 'provides the clients of an employee for an employee' do
      get :index, params: { employee_id: employee.id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [client2]
    end

    it 'provides the clients of a partner_companies contractor for a partner_commpany' do
      get :index, params: { partner_company_id: partner_company.id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [client3]
    end
  end
end
