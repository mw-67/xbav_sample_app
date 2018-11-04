class CreateContractors < ActiveRecord::Migration[5.2]
  def change
    create_table :contractors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :partner_company, foreign_key: true

      t.timestamps
    end
  end
end
