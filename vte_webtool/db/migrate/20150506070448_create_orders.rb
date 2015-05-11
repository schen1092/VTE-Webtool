class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date
      t.string :patient_name
      t.string :patient_id
      t.integer :visit_id
      t.string :orderset_key
      t.string :JHH_service
      t.string :vte_risk
      t.string :bleeding_risk
      t.string :risk_stratum
      t.string :appropriate_prophylaxis
      t.string :prescribed_prophylaxis
      t.string :compliance
      t.references :provider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
