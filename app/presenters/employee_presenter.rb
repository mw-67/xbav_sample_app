class EmployeePresenter < BasePresenter
  field :id
  field :first_name, label: 'First Name'
  field :last_name, label: 'Last Name'
  field :identifier
  field :company_name, link: :company_link, label: 'Partner Company Name'
  field :num_clients, link: :clients_link, label: '#Clients'

  delegate :id, :first_name, :last_name, :identifier, :company_name, :num_clients, to: :instance

  def self.instance_path_method
    :employee_path
  end

  def company_link(view)
    view.company_path(id: instance.company_id)
  end

  def clients_link(view)
    view.clients_path(employee_id: id)
  end
end
