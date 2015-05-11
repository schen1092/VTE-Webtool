class Order < ActiveRecord::Base
  belongs_to :provider



	def self.import(provider, file)
		CSV.foreach(file.path, headers:true) do |row|
			# Provider.create!(row.to_hash)
			provider.orders.create!(row.to_hash)
		end
	end
end
