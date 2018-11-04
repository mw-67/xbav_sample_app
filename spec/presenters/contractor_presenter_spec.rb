require 'rails_helper'

describe ContractorPresenter do
  let(:contractor) { create(:contractor) }

  subject { described_class.new(contractor) }

  it 'has fields' do
    expect(described_class.fields.size).to eq 6
  end

  describe 'delegates' do
    [ :id, :first_name, :last_name, :company_identity ].each do |method|
      it "delegates #{method} to instance" do
        expect(subject.send(method)).to eq contractor.send(method)
      end
    end
  end

  describe 'clients' do
    let(:client) { create(:client, first_name: 'm', last_name: 'w') }
    before :each do
      contractor.clients << client
      create(:client, first_name: 'un', last_name: 'linked')
    end

    it 'lists clients' do
      expect(subject.clients).to eq ["m w (#{client.ctoken})"]
    end
  end

  describe '#clients_no_employee' do
    let(:client) { create(:client, first_name: 'm', last_name: 'w') }
    before :each do
      contractor.clients << client
      client.employees << create(:employee)
    end

    it 'lists clients' do
      expect(subject.clients_no_employee).to be_empty
    end
  end

  describe 'links' do
    let(:view) { Rails.application.routes.url_helpers }

    it 'has a instance_path_method' do
      expect(described_class.instance_path_method).to eq :contractor_path
    end

    it 'provides a partner_company link' do
      expect(subject.partner_company_link(view)).to eq '/partner_companies/' + contractor.partner_company_id.to_s
    end

  end
end
