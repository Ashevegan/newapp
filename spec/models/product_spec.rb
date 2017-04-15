require 'rails_helper'

describe Property do
	context "when the property has comments" do 	
		before do 
			@property = Property.create!(address: "4 Washington Place", description: "Great location!", image_url: "Cat.jpg", price: 6000, neighborhood: "Gramercy")
			@user = User.create!(email: "albert.chen@nyu.edu", password: "careerFoundry" )
			@property.comments.create!(rating: 1, user: @user, body: "Awful apartment!")
			@property.comments.create!(rating: 3, user: @user, body: "No elevator.")
			@property.comments.create!(rating: 5, user: @user, body: "Perfect!")
		end
		it "returns the average rating of all comments" do
			expect(@property.average_rating).to eq 3
		end
		it "is not valid" do
			expect(Property.new(description: "Small BD")).not_to be_valid
		end
	end
end