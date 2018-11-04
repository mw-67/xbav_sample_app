require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { build(:company) }

  describe 'creation' do
    before :each do
      company.save
    end

    it 'is saved' do
      expect(company.persisted?).to be true
    end

    it 'is supplemented with an identity' do
      expect(company.identity).to match(/[A-Z]{4}:[A-Z]{4}/)
    end
  end

  describe 'identity protection' do
    before :each do
      company.save
    end

    it 'disallows to change the identity' do
      company.identity = 'bla'
      expect { company.save }.to raise_error(RuntimeError, 'attempt to modify identifier "identity" in Company:' + company.id.to_s)
    end
  end

  describe 'validations' do
    let(:company) { build(:company, name: nil) }

    it 'requires a name' do
      expect(company).not_to be_valid
    end
  end

  describe '#deletable?' do
    it 'is true without employees' do
      expect(company.deletable?).to be true
    end

    it 'is false with employees' do
      company.employees << build(:employee, company: company)
      expect(company.deletable?).to be false
    end
  end

  describe 'counter' do
    before :each do
      company.save!
    end

    describe '#num_employees' do
      before :each do
        create(:employee, company: company)
      end

      it 'counts emplyoees' do
        expect(company.num_employees).to eq 1
      end
    end

    describe '#num_clients' do
      before :each do
        employee = create(:employee, company: company)
        employee.clients << create(:client)
      end

      it 'counts clients' do
        expect(company.num_clients).to eq 1
      end
    end

    describe '#num_contractors' do
      before :each do
        employee = create(:employee, company: company)
        client = create(:client)
        employee.clients << client
        client.contractors << create(:contractor)
      end

      it 'counts contractors' do
        expect(company.num_contractors).to eq 1
      end
    end
  end
end
