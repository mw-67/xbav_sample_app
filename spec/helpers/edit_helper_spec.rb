require 'rails_helper'

describe EditHelper do
  include ERB::Util

  let(:instance) { create(:employee, first_name: 'who', last_name: 'ever') }

  describe '#edit_heading' do
    it 'is "Edit <model name>" for an existing instance' do
      expect(edit_heading(instance)).to eq 'Edit Employee'
    end

    it 'is "new <model name>" for a new instance' do
      expect(edit_heading(Employee.new)).to eq 'New Employee'
    end
  end

  describe '#edit_form' do
    it 'sets up a form' do
      expect(edit_form(instance)).to start_with("<form class=\"edit_employee\" id=\"edit_employee_#{instance.id}\" action=\"/employees/#{instance.id}\" accept-charset=\"UTF-8\" method=\"post\">")
    end
  end

  describe '#edit_input_field' do
    let(:inp_text) { "<input type=\"text\" value=\"#{instance.last_name}\" name=\"employee[last_name]\" id=\"employee_last_name\" />" }
    let(:inp_select) { "<select name=\"employee[company_id]\" id=\"employee_company_id\"><option selected=\"selected\" value=\"#{instance.company_id}\">#{instance.company.name}</option></select>" }

    it 'creates a text field for simple fields' do
      form_for(instance) do |form|
        expect(edit_input_field(form, 'last_name')).to eq inp_text
      end
    end

    it 'creates a selection for a relation' do
      form_for(instance) do |form|
        expect(edit_input_field(form, 'company_id')).to eq inp_select
      end
    end
  end

end
