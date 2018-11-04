require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  describe 'creation' do
    before :each do
      client.save!
    end

    it 'is saved' do
      expect(client.persisted?).to be true
    end

    it 'is supplemented with an identity' do
      expect(client.ctoken).to match(/[A-Z]{2}-[A-Z]{2}-[A-Z]{2}/)
    end
  end

  describe 'validations' do
    it 'is invalid without first name' do
      client = build(:client, first_name: '')
      expect(client.valid?).to be false
    end

    it 'is invalid without last name' do
      client = build(:client, last_name: '')
      expect(client.valid?).to be false
    end
  end

  describe '#deletable?' do
    it 'is true' do
      expect(client.deletable?).to be true
    end
  end
end
