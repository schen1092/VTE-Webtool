class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
    	t.integer :provider_id
      t.string :name
      t.string :jhed
      t.string :role

      t.timestamps null: false
    end
  end
end
