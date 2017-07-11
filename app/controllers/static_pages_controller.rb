class StaticPagesController < ApplicationController

  def index
  end
	
  def about
  end

  def contact
  end
  
  def landing_page
    @products = Product.limit(3)
  end

  def _carousel
    @product = Product.limit(3)
  
  def thank_you
  	@name = params[:name]
  	@email = params[:email]
  	@message = params[:message]
  	UserMailer.contact_form(@email, @name, @message).deliver_now
	end
end
