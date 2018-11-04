require 'rails_helper'

RSpec.describe PartnerCompaniesController, type: :controller do
  describe 'permitted params' do
    let(:params) { { 'name' => 'foo' } }
    let(:other) { { 'identity' => 'foo' } }

    it 'permitts name only' do
      controller.params = { company: params.merge(other) }
      expect(controller.send(:permitted_params)).to eq(params)
    end
  end
end
