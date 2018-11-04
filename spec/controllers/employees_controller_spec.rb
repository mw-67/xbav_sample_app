require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'permitted params' do
    let(:params) { { 'first_name' => 'x', 'last_name' => 'y', 'company_id' => 1 } }
    let(:other) { { 'bla' => 'blub' } }

    it 'permitts names and company_id only' do
      controller.params = { employee: params.merge(other) }
      expect(controller.send(:permitted_params)).to eq(params)
    end
  end

  describe 'scopes' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    before :each do
      sign_in
    end

    it 'returns all emploeyees without parameters' do
      get :index
      expect(assigns['collection'].size).to eq 2
    end

    it 'returns all employees for the company only when scoped to company' do
      get :index, params: { company_id: employee1.company_id }
      expect(assigns['collection'].size).to eq 1
      expect(assigns['collection']).to eq [employee1]
    end


  end
end
