require 'rails_helper'

describe DisplayHelper do
  include ERB::Util

  let(:presenter) { CompanyPresenter }
  let(:instance) { create(:company) }

  describe '#heading' do
    it 'provides a heading text' do
      expect(heading(presenter)).to eq 'Company'
    end
    it 'provides plural forms' do
      expect(heading(presenter, plural: true)).to eq 'Companies'
    end
  end

  describe '#header row' do
    let(:presenter) { double(Object, fields: [['first', {}], ['second', { label: 'SeconD' } ]]) }

    it 'uses the field name as label' do
      expect(header_row(presenter)).to include '<th>first</th>'
    end

    it 'uses the field name as label' do
      expect(header_row(presenter)).to include '<th>SeconD</th>'
    end
  end

  describe '#model row' do
    it 'includes the id as link' do
      expect(model_row(instance)).to include "<td><a href=\"/companies/#{instance.id}\">#{instance.id}</a></td>"
    end

    it 'include a link to employees coped by commpany' do
      expect(model_row(instance)).to include "<td><a href=\"/employees?company_id=#{instance.id}\">0</a></td>"
    end

    it 'works for models showing arrays as well' do
      expect(model_row(create(:client))).to include "<td></td>"
    end
  end

  describe '#instance_table' do
    it 'includes the id as link' do
      expect(instance_table(instance)).to include "<td><a href=\"/companies/#{instance.id}\">#{instance.id}</a></td>"
    end

    it 'include a link to employees coped by commpany' do
      expect(instance_table(instance)).to include "<td><a href=\"/employees?company_id=#{instance.id}\">0</a></td>"
    end
  end

  describe '#new_link' do
    it 'links to the new page' do
      expect(new_link(presenter)).to eq '<a href="/companies/new">New</a>'
    end
  end

  describe '#edit_link' do
    it 'links to the edit page' do
      expect(edit_link(instance)).to eq '<a href="/companies/' + instance.id.to_s + '/edit">Edit</a>'
    end
  end

  describe '#delete_link' do
    it 'links to the edit page' do
      expect(delete_link(instance)).to eq '<a rel="nofollow" data-method="delete" href="/companies/' + instance.id.to_s + '">Delete</a>'
    end
  end
end
