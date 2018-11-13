require 'rails_helper'

RSpec.describe PartnerCompaniesController, type: :controller do
  describe 'permitted params' do
    let(:params) { { 'name' => 'foo' } }
    let(:other) { { 'identity' => 'bar' } }

    it 'permitts name only' do
      controller.params = { partner_company: params.merge(other) }
      expect(controller.send(:permitted_params)).to eq(params)
    end
  end
end
