class CreateClientsContractors < ActiveRecord::Migration[5.2]
  def change
    create_table :clients_contractors do |t|
      t.references :client, foreign_key: true
      t.references :contractor, foreign_key: true

      t.timestamps
    end
  end
end
