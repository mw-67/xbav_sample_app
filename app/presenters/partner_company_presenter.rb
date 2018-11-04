class PartnerCompanyPresenter < BasePresenter
  field :id
  field :name, label: 'Name'
  field :identity
  field :num_contractors, link: :contractors_link, label: '#Contractors'
  field :num_clients, link: :clients_link, label: '#Clients'

  delegate :id, :name, :identity, :num_contractors, :num_clients, to: :instance

  def self.instance_path_method
    :partner_company_path
  end

  def contractors_link(view)
    view.contractors_path(partner_company_id: id)
  end

  def clients_link(view)
    view.clients_path(partner_company_id: id)
  end
end
