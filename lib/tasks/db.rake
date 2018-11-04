namespace :db do

  def create_objects(size)
    size.times do
      Company.create(name: Faker::Company.name)
      PartnerCompany.create(name: Faker::Company.name)
    end
    size.times do
      Employee.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      company: Company.order('random()').first)
      Contractor.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      partner_company: PartnerCompany.order('random()').first)
      Client.create(first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name)
    end
    size.times do
      client = Client.order('random()').first
      employee = Employee.order('random()').first
      next if ClientsEmployee.where(client: client, employee: employee).exists?
      ClientsEmployee.create(client: client, employee: employee)

      client = Client.order('random()').first
      contractor = Contractor.order('random()').first
      next if ClientsContractor.where(client: client, contractor: contractor).exists?
      ClientsContractor.create(client: client, contractor: contractor)
    end
  end

  desc 'populate database; provide number of records per table using SIZE (default 100)'
  task populate: :environment do
    size = ENV['SIZE'] || 100
    create_objects(size.to_i)
  end

  desc 'empty database'
  task clean: :environment do
    ClientsEmployee.delete_all
    ClientsContractor.delete_all
    Client.delete_all
    Contractor.delete_all
    Employee.delete_all
    Company.delete_all
    PartnerCompany.delete_all
  end
end
