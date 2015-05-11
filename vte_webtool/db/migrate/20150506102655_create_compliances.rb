class CreateCompliances < ActiveRecord::Migration
  def change
    create_table :compliances do |t|
      t.date :date
      t.float :result
      t.references :provider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
