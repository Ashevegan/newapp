require 'rails_helper'

describe Product do

end

before do
    @product = Product.create!(name: "race bike")
    @user = User.create!(email: "theashley.elyse@gmail.com", password: "haven007")
    @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
    @product.comments.create!(rating: 3, user: @user, body: "Nice bike!")
    @product.comments.create!(rating: 5, user: @user, body: "What a beauty!")
end

it "returns the average of all comments" do

      expect(@product.average_rating).to eq 3
    end

    it "is not valid" do
      expect(Product.new(description: "Shinola")).not_to be_valid
    end
  end
end