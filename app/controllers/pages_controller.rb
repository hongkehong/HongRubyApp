class PagesController < ApplicationController
  def post
	@title="Make a Micropost"
   @micropost = Micropost.new if signed_in?
  end

  def action2
   @title="action2"
  end
  def home
   @title="home"
   if signed_in?
     @feed_items = current_user.feed.paginate(:page => params[:page])
   end
  end
end
