require 'spec_helper'

describe FeedsListsController do
	before :each do
		@user = User.create(:name => 'examasde', :email => 'sadasd@yahoo.com', :password => 'dddddd', :password_confirmation => 'dddddd')
		sign_in(@user)
	end
	describe 'showing a feedslist' do
		it 'should display the feedslist'  do
		   @user.feeds_lists << FeedsList.create(name: 'asdasd')
		   feeds_list = @user.feeds_lists.first
		   get :show, {user_id: @user.id, id: feeds_list.id}
		   assert_response :success
		end
	end
	describe 'new feedslist page' do
		it 'should display the new feedslist page'  do
		   FeedsList.should_receive(:new)
		   get :new, {user_id: @user.id}
		end
	end
	describe 'create feedslist' do
		it 'should save the feedslist'  do
		   assert_difference('FeedsList.count') do
		     post :create, {user_id: @user.id, feeds_list: {name: 'asda', is_private: false, feeds: [""]}}
		   end
		end
	end
	describe 'edit feedslist' do
		it 'should display the edit feedslist page'  do
			 @user.feeds_lists << FeedsList.create(name: 'asdasd')
		   feeds_list = @user.feeds_lists.first
		   get :edit, {user_id: @user.id, id: feeds_list.id}
		   assert_response :success
		end
	end
	describe 'update feedslist' do
		it 'should update the feedslist'  do
			 @user.feeds_lists << FeedsList.create(name: 'asdasd')
		   feeds_list = @user.feeds_lists.first
		   post :update, {user_id: @user.id, id: feeds_list.id, feeds_list: {name: 'asda', is_private: false, feeds: [""]}}
		end
	end
	describe 'delete feedslist' do
		it 'should delete the feedslist'  do
			 @user.feeds_lists << FeedsList.create(name: 'asdasd')
		   feeds_list = @user.feeds_lists.first
		   get :destroy, {user_id: @user.id, id: feeds_list.id}
		end
	end
end