require 'rails_helper'

describe EmployeePresenter do
  let(:employee) { create(:employee) }

  subject { described_class.new(employee) }

  it 'has fields' do
    expect(described_class.fields.size).to eq 6
  end

  describe 'delegates' do
    [ :id, :first_name, :last_name, :identifier, :company_name, :num_clients ].each do |method|
      it "delegates #{method} to instance" do
        expect(subject.send(method)).to eq employee.send(method)
      end
    end
  end

  describe 'links' do
    let(:view) { Rails.application.routes.url_helpers }

    it 'has a instance_path_method' do
      expect(described_class.instance_path_method).to eq :employee_path
    end

    it 'provides a company link' do
      expect(subject.company_link(view)).to eq '/companies/' + employee.company_id.to_s
    end

    it 'provides a clients link' do
      expect(subject.clients_link(view)).to eq '/clients?employee_id=' + employee.id.to_s
    end
  end
end
