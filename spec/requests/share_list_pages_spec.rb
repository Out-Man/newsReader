require 'spec_helper'

describe "share list pages" do

  subject { page }

  describe "when user signed in" do

    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }
    let(:article) { FactoryGirl.create(:article) }

    describe "create share list" do
      before {visit article_path(article)}
      it {should have_link('Share to Friends')}

      describe "visit profile page" do
        before do
          click_link 'Share to Friends'
          visit user_path(user)
        end
        it { should have_selector('h5', text: 'Shared Articles') }
        it {should have_link(article.title)}
        it {should have_link('Delete')}

        describe "delete a article" do
          before {click_link 'Delete'}
          it { should_not  have_selector('h5', text: 'Share to Friends') }
        end
      end
    end
  end
end
