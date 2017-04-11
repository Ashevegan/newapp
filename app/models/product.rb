class Product < ApplicationRecord
  has_many :orders
  has_many :comments
  
  validates :name, presence: true
  
  validates :image_url, presence: true
  
  validates :price, presence: true
	def highest_rating_comment
		comments.rating_desc.first		
	end
	def lowest_rating_comment
		comments.rating_desc.last
	end
	def average_rating
		comments.average(:rating).to_f
	end
	
end