require 'test_helper'

include Devise::TestHelpers

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    @user = users(:one)
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    @user = users(:one)
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create post" do
    @user = users(:one)
    sign_in @user
    assert_difference('Post.count') do
      post :create, :post => @post.attributes
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    @user = users(:one)
    sign_in @user
    get :show, :id => @post.to_param
    assert_response :success
  end

  test "should get edit" do
    @user = users(:one)
    sign_in @user
    get :edit, :id => @post.to_param
    assert_response :success
  end

  test "should update post" do
    @user = users(:one)
    sign_in @user
    put :update, :id => @post.to_param, :post => @post.attributes
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    @user = users(:one)
    sign_in @user
    assert_difference('Post.count', -1) do
      delete :destroy, :id => @post.to_param
    end

    assert_redirected_to posts_path
  end
end
