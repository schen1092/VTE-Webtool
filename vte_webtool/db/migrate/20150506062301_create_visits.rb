class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visit_id
      t.date :date
      t.references :provider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
