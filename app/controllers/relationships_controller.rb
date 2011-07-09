class RelationshipsController < ApplicationController
  before_filter :authenticate
  before_filter :get_followed_user

  def create
    current_user.follow!(@user)
    #no correspoing pages, no need!
    #call user.follow! to create relationship: a_user.relationships.create!(:followed_id => followed.id)
    
	 redirect_to @user
    #respond_to do |format|
    #  format.html { redirect_to @user }
    #  format.js
    #end

  end

  def destroy
    current_user.unfollow!(@user)
    redirect_to @user
    #respond_to do |format|
    #  format.html { redirect_to @user }
    #  format.js
    #end
  end

  private

    def get_followed_user
      @user = User.find(params[:relationship][:followed_id])
    end
end

