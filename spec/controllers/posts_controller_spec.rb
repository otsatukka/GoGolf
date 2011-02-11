require 'spec_helper'

describe PostsController do
  
  before (:each) do
    @user = Factory(:user)
    
    sign_in @user
  end

  describe "GET 'index'" do
    it "should be successful" do
      @user.roles = Role.create!(:name => "Admin")
      get 'index'
      response.should be_success
    end
  end
  
  describe "GET 'new'" do
    it "should be successful" do
      @user.roles = Role.create!(:name => "Admin")
      get 'new'
      response.should be_success
    end
  end
end