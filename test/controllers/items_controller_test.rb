require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get items_index_url
    assert_response :success
  end

  test "should get new" do
    get items_new_url
    assert_response :success
  end

  test "should get show" do
    get items_show_url
    assert_response :success
  end

  test "should get comfirm" do
    get items_comfirm_url
    assert_response :success
  end

  test "should get complete" do
    get items_complete_url
    assert_response :success
  end

end
