class StaticPagesController < ApplicationController
  def home
  	@providers = Provider.all
  end

  def help
  end

  def about
  end

	def contact
  end
end
