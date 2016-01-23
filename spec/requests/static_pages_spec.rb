require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit root_path
      page.should have_selector('title', :text => "NewsReader")
    end
  end
end