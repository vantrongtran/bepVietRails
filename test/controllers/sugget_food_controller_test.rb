require 'test_helper'

class SuggetFoodControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sugget_food_index_url
    assert_response :success
  end

end
