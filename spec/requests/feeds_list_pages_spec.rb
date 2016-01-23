require 'spec_helper'

describe "feedslist pages" do

  subject { page }

  describe "when user didn't sign in" do
    let(:user) { FactoryGirl.create(:user) }
    before { put new_user_feeds_list_path(user) }
    specify { response.should redirect_to(signin_path) }
  end

  describe "when user signed in" do

    let(:user) { FactoryGirl.create(:user) }
    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
    before { sign_in user }
    let(:feeds_list) {FactoryGirl.create(:feeds_list, user: user)}

    let(:feed) {FactoryGirl.create(:feed)}

    describe "feedslist creation" do
      before { visit new_user_feeds_list_path(user) }

      describe "with invalid information" do

        it "should not create a feedslist" do
          expect { click_button "Create FeedsList" }.not_to change(FeedsList, :count)
        end

        describe "error messages" do
          before { click_button "Create FeedsList" }
          it { should have_content('error') } 
        end
      end

      describe "with valid information" do

        describe "non private" do
          before do
            fill_in 'Name', with: "Lorem ipsum"
          end
          it "should create a feedslist" do
            expect { click_button "Create FeedsList" }.to change(FeedsList, :count).by(1)
          end
        end

        describe "private" do
          before do
            fill_in "Name", with: "Lorem ipsum" 
            check "Make Private?"
          end
          it "should create a feedslist" do
            expect { click_button "Create FeedsList" }.to change(FeedsList, :count).by(1)
          end
          describe "another user visit this list" do
            describe "should not see this list" do
              before { visit user_path(wrong_user) }
              it {should_not have_link("Lorem ipsum")}
            end
            describe "should redirect to home page" do
              before { put user_path(wrong_user) }
              specify { response.should redirect_to(root_path) }
            end
            describe "should redirect to home page when visiting a feedlist" do
              before { put user_feeds_list_path(wrong_user, feeds_list)}
              specify { response.should redirect_to(root_path) }
            end
          end
        end
      end
    end

    describe "feedslist destruction" do
      before { FactoryGirl.create(:feeds_list, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a feedslist" do
          expect { click_link "Delete FeedsList" }.to change(FeedsList, :count).by(-1)
        end
      end
    end

    describe "feedslist edit" do
      before { FactoryGirl.create(:feeds_list, user: user) }

      describe "as correct user" do
        before { visit root_path }

        it "should delete a feedslist" do
          expect { click_link "Edit FeedsList" }.to change(FeedsList, :count).by(0)
        end
      end
    end
  end
end