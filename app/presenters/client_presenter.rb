class ClientPresenter < BasePresenter
  field :id
  field :first_name, label: 'First Name'
  field :last_name, label: 'Last Name'
  field :consultants, label: 'Consultants'

  delegate :id, :first_name, :last_name, to: :instance

  def self.instance_path_method
    :client_path
  end

  def consultants
    (instance.employees.order(:id) + instance.contractors.order(:id)).map do |consultant|
      '%s %s @ %s' % [ consultant.first_name, consultant.last_name, consultant.company_name ]
    end
  end
end
