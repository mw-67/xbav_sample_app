class Contractor < ApplicationRecord
  belongs_to :partner_company
  has_many :clients_contractors
  has_many :clients, through: :clients_contractors

  validates :first_name, :last_name, presence: true

  def company_name
    partner_company.name
  end

  def company_identity
    partner_company.identity
  end

  def num_clients
    clients.count
  end

  def deletable?
    clients.empty?
  end
end
