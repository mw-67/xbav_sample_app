require 'rails_helper'

RSpec.describe PartnerCompany, type: :model do

  let(:partner_company) { build(:partner_company) }

  describe 'creation' do
    before :each do
      partner_company.save
    end

    it 'is saved' do
      expect(partner_company.persisted?).to be true
    end

    it 'is supplemented with an identity' do
      expect(partner_company.identity).to match(/P\/[A-Z]{4}/)
    end
  end

  describe 'validations' do
    let(:partner_company) { build(:partner_company, name: nil) }

    it 'requires a name' do
      expect(partner_company).not_to be_valid
    end
  end

  describe '#deletable?' do
    it 'is true without contractors' do
      expect(partner_company.deletable?).to be true
    end

    it 'is false with contractors' do
      partner_company.contractors << build(:contractor, partner_company: partner_company)
      expect(partner_company.deletable?).to be false
    end
  end

  describe 'counter' do
    before :each do
      partner_company.save!
    end

    describe '#num_contractors' do
      before :each do
        create(:contractor, partner_company: partner_company)
      end

      it 'counts contractors' do
        expect(partner_company.num_contractors).to eq 1
      end
    end

    describe '#num_clients' do
      before :each do
        contractor = create(:contractor, partner_company: partner_company)
        contractor.clients << create(:client)
      end

      it 'counts clients' do
        expect(partner_company.num_clients).to eq 1
      end
    end
  end
end
