require 'spec_helper'

describe UsersController do
	before :each do
		@user = User.create(:name => 'example', :email => 'example@yahoo.com', :password => 'dddddd', :password_confirmation => 'dddddd')
		sign_in(@user)
	end
	describe 'showing a user' do
		it 'should display the user profile page'  do
			#fake_result = mock('user', :name => 'example', :email => 'example@yahoo.com', :password => 'dddddd', :password_confirmation => 'dddddd')
			User.should_receive(:find).with("#{@user.id}")
			get :show, {:id => @user.id}
		end
	end
	describe 'new user' do
		it 'should display the user signup page'  do
			User.should_receive(:new)
			get :new
		end
	end
	describe 'update user profile' do
		it 'should call update_attributes'  do
			#User.should_receive(:update_attributes)
			post :update, {id: @user.id}
			assert_response :success
		end
	end
end