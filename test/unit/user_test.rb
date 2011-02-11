require 'test_helper'

class UserTest < Test::Unit::TestCase
  
# This user should be valid by construction. 
  def test_user_validity
    assert users(:valid_user).valid? 
  end
# This user should be invalid by construction. 
  def test_user_invalidity
    assert !users(:invalid_user).valid? 
  end
end

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end