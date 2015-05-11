class UpdateProviders < ActiveRecord::Migration
  def change
  	change_table :providers do |t|
  		t.remove :provider_id
  		t.rename :name, :ORDERING_PROVIDER
  		t.rename :jhed, :ORDERING_PROV_JHED_ID
  		t.rename :role, :ORDERING_PROVIDER_ROLE

  	end
  end
end
