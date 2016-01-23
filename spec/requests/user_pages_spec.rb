require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "profile page" do
	    let(:user) { FactoryGirl.create(:user) }
	    before { visit user_path(user) }
	    it { should have_selector('title', text: 'NewsReader') }
	end

  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('title', text: 'NewsReader') }
  end

  describe "signup" do
  	before { visit signup_path }
  	let(:submit) { "Create Account" }

  	describe "with invalid information" do
	     it "should not create a user" do
	        expect { click_button submit }.not_to change(User, :count)
	      end
    end

    describe "with valid information" do
    	before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
     	end
     	it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
     	end
  	end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save changes"
      end
      it { should have_link('Log Out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "create feedslist" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit new_user_feeds_list_path(user)
    end

    describe "with invalid information" do
      before { click_button "Create FeedsList" }
      it { should have_content('error') }
    end
  end
end