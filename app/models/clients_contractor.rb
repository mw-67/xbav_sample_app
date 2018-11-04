class ClientsContractor < ApplicationRecord
  belongs_to :client
  belongs_to :contractor
end
