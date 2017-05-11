require 'test_helper'

class SuggestFoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get suggest_foods_index_url
    assert_response :success
  end

end
