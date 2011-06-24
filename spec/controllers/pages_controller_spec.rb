require 'spec_helper'

describe PagesController do
	integrate_views
  #Delete these examples and add some real ones
  #it "should use PagesController" do
  #  controller.should be_an_instance_of(PagesController)
  #end

  before(:each) do
	 @var_me = "HAHA"
  end

  describe "GET 'action1'" do
    it "should be successful" do
      get 'action1'
      response.should be_success
    end
    it "should have the right title" do
       get 'action1'
       response.should have_tag("title",
                           "#{@var_me} | action1")
	 end
  end

  describe "GET 'action2'" do
    it "should be successful" do
      get 'action2'
      response.should be_success
    end
  end
end
