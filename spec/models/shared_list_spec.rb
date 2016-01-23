require 'spec_helper'

describe SharedList do

	let(:user) { FactoryGirl.create(:user) }
  	before do
    	@shared_list = SharedList.new(user_id: user.id)
  	end

  	subject { @shared_list }

  	it { should respond_to(:user_id) }

  	describe "when user_id is not present" do
    	before { @shared_list.user_id = nil }
    	it { should_not be_valid }
  	end	
end