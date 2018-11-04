class CreateClientsEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :clients_employees do |t|
      t.references :client, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
