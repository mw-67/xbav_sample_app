class Company < ApplicationRecord
  include Concerns::Identifier

  has_many :employees
  has_many :clients, through: :employees
  has_many :contractors, through: :employees

  validates :name, presence: true

  identifier :identity, 'cccc:cccc'

  def num_employees
    employees.count
  end

  def num_contractors
    contractors.count
  end

  def num_clients
    clients.count
  end

  def deletable?
    employees.empty?
  end
end
