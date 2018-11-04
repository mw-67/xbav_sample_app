require 'rails_helper'

describe CompanyPresenter do
  let(:company) { create(:company) }

  subject { described_class.new(company) }

  it 'has fields' do
    expect(described_class.fields.size).to eq 6
  end

  describe 'delegates' do
    [ :id, :name, :identity, :num_contractors, :num_clients ].each do |method|
      it "delegates #{method} to instance" do
        expect(subject.send(method)).to eq company.send(method)
      end
    end
  end

  describe 'links' do
    let(:view) { Rails.application.routes.url_helpers }

    it 'has a instance_path_method' do
      expect(described_class.instance_path_method).to eq :company_path
    end

    it 'provides a employees link' do
      expect(subject.employees_link(view)).to eq '/employees?company_id=' + company.id.to_s
    end

    it 'provides a contractors link' do
      expect(subject.contractors_link(view)).to eq '/contractors?company_id=' + company.id.to_s
    end

    it 'provides a clients link' do
      expect(subject.clients_link(view)).to eq '/clients?company_id=' + company.id.to_s
    end
  end
end
