require 'rails_helper'

describe UsersController, :type => :contoller do 

  before do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end

  describe 'GET#show' do
    context 'User is logged in' do
      before do
        sign_in user
      end  
      it "loads correct user details" do 
        get :show, params: {id: user.id}

        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq @user
      end  
    end

    context 'No user is logged in' do 
      it 'redirects to login' do 
        get :show, id: user.id    
      end  
    end 

    context 'Cannont access second users show page' do 
      it "redirects to root" do
        get :show, params: {id: user.id}
        redirect_to(root_path)
      end
    end    
  
  end
end 