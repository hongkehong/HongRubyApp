require 'spec_helper'

describe "LayoutLinks" do
 it "should have a page at '/action1'" do
    get '/action1'
    response.should render_template('pages/action1')
  end
 it "should have a signup page at '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end
 it "should have a home page at '/'" do
    get '/'
    response.should render_template('pages/home')
  end
end
