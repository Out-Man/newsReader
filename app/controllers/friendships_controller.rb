class FriendshipsController < ApplicationController
  before_filter :signed_in_user

  def create
    invitee = User.find_by_id(params[:user_id])
    if current_user.invite invitee
      
      redirect_to request.referrer, :notice => "Successfully invited friend!"
    else
      redirect_to request.referrer, :notice => "Sorry! You can't invite that user!"
    end
  end

  def update
    inviter = User.find_by_id(params[:id])
    if current_user.approve inviter
      redirect_to request.referrer, :notice => "Successfully confirmed friend!"
    else
      redirect_to request.referrer, :notice => "Sorry! Could not confirm friend!"
    end
  end
  
  def destroy
    user = User.find_by_id(params[:id])
    if current_user.remove_friendship user
      redirect_to request.referrer, :notice => "Successfully removed friend!"
    else
      redirect_to request.referrer, :notice => "Sorry, couldn't remove friend!"
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end  
end
