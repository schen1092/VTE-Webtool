

class ProvidersController < ApplicationController

	require 'csv'

	def show
		@provider = Provider.find(params[:id])
		@title = "Overview"
	end

	def create
		@provider = Provider.new(provider_params)
		@provider.save
		redirect_to @provider
	end

	def ranking
		@provider = Provider.find(params[:id])
		@title = "Ranking"
	end
	def trends
		@provider = Provider.find(params[:id])
		@title = "Trends"
	end
	def compliance
		@provider = Provider.find(params[:id])
		@title = "Compliance"
	end

	def import
	  Provider.import(params[:file])
	  redirect_to root_url, notice: "Providers imported."
	end

	private
	  def provider_params
	    params.require(:provider).permit(:ORDERING_PROVIDER, :ORDERING_PROV_JHED_ID, :ORDERING_PROVIDER_ROLE)
	  end
end
