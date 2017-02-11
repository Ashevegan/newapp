class StaticPagesController < ApplicationController
	def landing_page 
		@featured_product = Product.first
  
  def about
  end

  def contact
  end
end
