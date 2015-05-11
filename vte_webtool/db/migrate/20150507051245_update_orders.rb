class UpdateOrders < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
  		t.remove :date, :patient_id, :vte_risk, :bleeding_risk, :risk_stratum, :appropriate_prophylaxis, :prescribed_prophylaxis
  		
  		t.rename :orderset_key, :ORDERSET_KEY
  		t.rename :visit_id, :VISITID
  		t.date :ORD_DT
  		t.date :ADMISSION_DATE
  		t.rename :JHH_service, :JHH_SERVICE
  		t.string :CAT_NAME
  		t.integer :CAT_CODE
  		t.rename :compliance, :MEDICATION_COMPLIANCE
  		t.rename :patient_name, :PATIENT_NAME
  		t.string :HISTORY_NO
   	end
  end
end
