class CreatePartnerCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :partner_companies do |t|
      t.string :name, null: false
      t.string :identity, null: false

      t.timestamps
    end
  end
end
