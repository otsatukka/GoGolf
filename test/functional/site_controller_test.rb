require File.dirname(__FILE__) + '/../test_helper'
require 'site_controller'

class SiteController; def rescue_action(e) raise e end; end
class SiteControllerTest < ActionController::TestCase
  def setup
    @controller = SiteController.new
    @request	= ActionController::TestRequest.new
    @response	= ActionController::TestResponse.new
  end
# Replace this with your real tests.
  test "test_truth" do
    assert true
  end

  test "should_get_index" do
    get :index
    assert_response :success
  end
end