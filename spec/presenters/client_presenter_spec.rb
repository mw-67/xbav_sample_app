require 'rails_helper'

describe ClientPresenter do
  let(:client) { create(:client) }

  subject { described_class.new(client) }

  it 'has fields' do
    expect(described_class.fields.size).to eq 4
  end

  describe 'delegates' do
    [ :id, :first_name, :last_name ].each do |method|
      it "delegates #{method} to instance" do
        expect(subject.send(method)).to eq client.send(method)
      end
    end
  end

  describe 'consultants' do
    before :each do
      client.employees << create(:employee)
      client.contractors << create(:contractor)
    end

    it 'provides employees and contractors as consultants' do
      expect(subject.consultants.size).to eq 2
    end
  end

  describe 'links' do
    let(:view) { Rails.application.routes.url_helpers }

    it 'has a instance_path_method' do
      expect(described_class.instance_path_method).to eq :client_path
    end
  end
end
