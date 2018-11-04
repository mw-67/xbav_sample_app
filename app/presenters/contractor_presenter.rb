class ContractorPresenter < BasePresenter
  field :id
  field :first_name, label: 'First Name'
  field :last_name, label: 'Last Name'
  field :company_identity, link: :partner_company_link, label: 'Partner Company identity'
  field :clients, label: 'Clients'
  field :clients_no_employee, label: 'Clients without Employee-Consultant'

  delegate :id, :first_name, :last_name, :company_identity, to: :instance

  def self.instance_path_method
    :contractor_path
  end

  def partner_company_link(view)
    view.partner_company_path(id: instance.partner_company_id)
  end

  def clients
    client_names instance.clients.order(:id)
  end

  def clients_no_employee
    client_names instance.clients.order(:id).select { |client| client.employees.blank? }
  end

  private

  def client_names(list)
    list.map { |client| client_name(client) }
  end

  def client_name(client)
    '%s %s (%s)' % [client.first_name, client.last_name, client.ctoken]
  end
end
