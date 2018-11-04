require 'rails_helper'

RSpec.describe Contractor, type: :model do
  let(:contractor) { build(:contractor) }

  describe 'creation' do
    before :each do
      contractor.save!
    end

    it 'is saved' do
      expect(contractor.persisted?).to be true
    end
  end

  describe '#company_name' do
    it 'provides the company name' do
      expect(contractor.company_name).to eq contractor.partner_company.name
    end
  end

  describe '#company_identity' do
    it 'provides the company identity' do
      expect(contractor.company_identity).to eq contractor.partner_company.identity
    end
  end

  describe '#num_clients' do
    before :each do
      contractor.save!
      contractor.clients << create(:client)
      contractor.clients << create(:client)
    end

    it 'count clients' do
      expect(contractor.num_clients).to eq 2
    end
  end

  describe '#deletable?' do
    it 'is true without clients' do
      expect(contractor.deletable?).to be true
    end

    it 'is false with clients' do
      contractor.save!
      contractor.clients << create(:client)
      expect(contractor.deletable?).to be false
    end
  end
end
