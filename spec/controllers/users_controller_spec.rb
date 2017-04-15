require 'rails_helper'

describe UsersController, :type => :controller do 
	#let(:user) { User.create!(email: 'peter@example.com', password: '123456790') }
	before do
		#@user = User.create!(email: "ac3639@gmail.com", password: "football2")
		@user = FactoryGirl.create(:user)
		@user_1 = User.create!(email: "achen.opg@gmail.com", password: "careerFoundry")
	end

	describe 'GET #show' do

		context "User is logged in" do 
			before do
				sign_in @user 
				get :show, params: { id: @user.id }
			end 

			it "loads correct user details" do
				expect(response).to be_success
				expect(response). to have_http_status(200)
				expect(assigns(:user)).to eq @user
			end
		end

		context "No user is logged in" do 
			before do
				get :show, params: { id: @user.id }
			end

			it "redirects to login" do 
				expect(response).to redirect_to(new_user_session_path)
			end
		end 

		context "User is logged in and tries to access user_1 details" do
			before do 
				get :show, params: { id: @user_1.id }
			end

			it "redirects to login" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end	
	end
end