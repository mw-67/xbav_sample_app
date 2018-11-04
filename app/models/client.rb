class Client < ApplicationRecord
  include Concerns::Identifier

  has_many :clients_employees, dependent: :destroy
  has_many :employees, through: :clients_employees
  has_many :clients_contractors, dependent: :destroy
  has_many :contractors, through: :clients_contractors

  validates :first_name, :last_name, presence: true

  identifier :ctoken, 'cc-cc-cc'

  def deletable?
    true
  end
end
