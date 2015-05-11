class OrdersController < ApplicationController

	require 'csv'

	def import
		@provider = Provider.find(params[:provider_id])
	  Order.import(@provider, params[:file])
	  redirect_to root_url, notice: "Orders imported."
	end
end
