class CompanyPresenter < BasePresenter
  field :id
  field :name, label: 'Name'
  field :identity
  field :num_employees, link: 'employees_link', label: '#Employees'
  field :num_contractors, link: 'contractors_link', label: '#Contractors'
  field :num_clients, link: 'clients_link', label: '#Clients'

  delegate :id, :name, :identity, :num_employees, :num_contractors, :num_clients, to: :instance

  def self.instance_path_method
    :company_path
  end

  def employees_link(view)
    view.employees_path(company_id: id)
  end

  def contractors_link(view)
    view.contractors_path(company_id: id)
  end

  def clients_link(view)
    view.clients_path(company_id: id)
  end
end
