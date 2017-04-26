
require 'rails_helper'

describe User do

  context "Email Address is missing" do

    it "is not valid" do

      expect(User.new(email:"")).not_to be_valid

    end

  end

  context "Password is missing" do

    it "is not valid" do
      expect(User.new(password:"")).not_to be_valid
    end

  end

end