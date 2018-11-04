class Employee < ApplicationRecord
  include Concerns::Identifier

  belongs_to :company
  has_many :clients_employees
  has_many :clients, through: :clients_employees
  has_many :contractors, through: :clients

  validates :first_name, :last_name, presence: true

  identifier :identifier, 'cc-cc-cc'

  def company_name
    company.name
  end

  def num_clients
    clients.count
  end

  def deletable?
    clients.empty?
  end
end
