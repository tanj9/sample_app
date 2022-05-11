class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user_to_follow = User.find(params[:followed_id])
    current_user.follow(@user_to_follow)
    respond_to do |format|
      format.html { redirect_to @user_to_follow }
      format.js
    end
  end

  def destroy
    @user_to_unfollow = Relationship.find(params[:id]).followed
    current_user.unfollow(@user_to_unfollow)
    respond_to do |format|
      format.html { redirect_to @user_to_unfollow }
      format.js
    end
  end
end
