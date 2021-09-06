require "test_helper"

class PastPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get past_plans_index_url
    assert_response :success
  end

  test "should get show" do
    get past_plans_show_url
    assert_response :success
  end

  test "should get create" do
    get past_plans_create_url
    assert_response :success
  end

  test "should get update" do
    get past_plans_update_url
    assert_response :success
  end

  test "should get destroy" do
    get past_plans_destroy_url
    assert_response :success
  end
end
