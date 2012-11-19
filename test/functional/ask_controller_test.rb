require 'test_helper'

class AskControllerTest < ActionController::TestCase
  test "should get chapters" do
    get :chapters
    assert_response :success
  end

  test "should get chapter" do
    get :chapter
    assert_response :success
  end

  test "should get learn" do
    get :learn
    assert_response :success
  end

  test "should get test" do
    get :test
    assert_response :success
  end

end
