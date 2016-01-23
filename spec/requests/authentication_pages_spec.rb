require 'spec_helper'

describe "Authentication" do

    subject { page }

    describe "signin page" do
    	before { visit signin_path }
    	it { should have_selector('title', text: 'NewsReader') }
  	end

    describe "signin" do
    	before { visit signin_path }

    	describe "with invalid information" do
      		before { click_button "Log In" }

      		it { should have_selector('title', text: 'NewsReader') }
      		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      		describe "after visiting another page" do
        		before { click_link "NEWSREADER DIGEST" }
        		it { should_not have_selector('div.alert.alert-error') }
        	end
    	end
    	describe "with valid information" do
      		let(:user) { FactoryGirl.create(:user) }
      		before do
        		fill_in "Email",    with: user.email
        		fill_in "Password", with: user.password
        		click_button "Log In"
      		end
      		it { should have_selector('title', text: 'NewsReader') }
      		it { should have_link('Edit Profile', href: edit_user_path(user)) }
      		it { should have_link('Log Out', href: signout_path) }
      		it { should_not have_link('Log In', href: signin_path) }
          describe "followed by signout" do
            before { click_link "Log Out" }
            it { should have_link('Log In') }
          end
      end
  	end

    describe "authorization" do

      describe "for non-signed-in users" do
        let(:user) { FactoryGirl.create(:user) }

        describe "in the Users controller" do

          describe "visiting the edit page" do
            before { visit edit_user_path(user) }
            it { should have_selector('title', text: 'NewsReader') }
          end

          describe "submitting to the update action" do
            before { put user_path(user) }
            specify { response.should redirect_to(signin_path) }
          end
        end
      describe "as wrong user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
        before { sign_in user }

        describe "visiting Users#edit page" do
          before { visit edit_user_path(wrong_user) }
        end

        describe "submitting a PUT request to the Users#update action" do
          before { put user_path(wrong_user) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
  end
end