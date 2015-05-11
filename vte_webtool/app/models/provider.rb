class Provider < ActiveRecord::Base
	has_many :orders, dependent: :destroy
	has_many :compliances, dependent: :destroy

	# attr_accessible :ORDERING_PROVIDER, :ORDERING_PROV_JHED_ID, :ORDERING_PROVIDER_ROLE

	def self.import(file)
		CSV.foreach(file.path, headers:true) do |row|
			# Provider.create!(row.to_hash)
			prov = Provider.find_by(ORDERING_PROV_JHED_ID: row['ORDERING_PROV_JHED_ID']) || Provider.create(row.to_hash)
	    # provider.attributes = row.to_hash.slice(*accessible_attributes)
	    prov.save!
		end
	end

end
