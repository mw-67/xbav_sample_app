require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { build(:employee) }

  describe 'creation' do
    before :each do
      employee.save!
    end

    it 'is saved' do
      expect(employee.persisted?).to be true
    end

    it 'is supplemented with an identity' do
      expect(employee.identifier).to match(/[A-Z]{2}-[A-Z]{2}-[A-Z]{2}/)
    end
  end

  describe '#company_name' do
    it 'provides the company name' do
      expect(employee.company_name).to eq employee.company.name
    end
  end

  describe '#num_clients' do
    before :each do
      employee.save!
      employee.clients << create(:client)
      employee.clients << create(:client)
    end

    it 'count clients' do
      expect(employee.num_clients).to eq 2
    end
  end

  describe '#deletable?' do
    it 'is true without clients' do
      expect(employee.deletable?).to be true
    end

    it 'is false with clients' do
      employee.save!
      employee.clients << create(:client)
      expect(employee.deletable?).to be false
    end
  end
end
