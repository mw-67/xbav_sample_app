class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :identifier, null: false
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
