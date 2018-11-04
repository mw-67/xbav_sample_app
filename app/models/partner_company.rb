class PartnerCompany < ApplicationRecord
  include Concerns::Identifier

  has_many :contractors
  has_many :clients, through: :contractors

  validates :name, presence: true

  identifier :identity, 'P/cccc'

  def num_contractors
    contractors.count
  end

  def num_clients
    clients.count
  end

  def deletable?
    contractors.empty?
  end
end
