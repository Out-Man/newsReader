module FriendshipsHelper

  def pending_requests
    @pending_requests = current_user.pending_invited_by
  end

  def pending_invites
    @pending_invites = current_user.pending_invited
  end

  def pending_invite?
    current_user.invited? self.profile_user
  end

  def pending_request?
    current_user.invited_by? self.profile_user
  end

  def profile_user
    @profile_user = User.find(params[:id])
  end

  def friend_with?
    current_user.friend_with? self.profile_user
  end

end
