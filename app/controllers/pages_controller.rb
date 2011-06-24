class PagesController < ApplicationController
  def action1
	@title="action1"
  end

  def action2
   @title="action2"
  end
  def home
   @title="home"
  end
end
