require 'rails_helper'

describe PartnerCompanyPresenter do
  let(:partner_company) { create(:partner_company) }

  subject { described_class.new(partner_company) }

  it 'has fields' do
    expect(described_class.fields.size).to eq 5
  end

  describe 'delegates' do
    [ :id, :name, :identity, :num_contractors, :num_clients ].each do |method|
      it "delegates #{method} to instance" do
        expect(subject.send(method)).to eq partner_company.send(method)
      end
    end
  end

  describe 'links' do
    let(:view) { Rails.application.routes.url_helpers }

    it 'has a instance_path_method' do
      expect(described_class.instance_path_method).to eq :partner_company_path
    end

    it 'provides a contractors link' do
      expect(subject.contractors_link(view)).to eq '/contractors?partner_company_id=' + partner_company.id.to_s
    end

    it 'provides a clients link' do
      expect(subject.clients_link(view)).to eq '/clients?partner_company_id=' + partner_company.id.to_s
    end
  end
end
