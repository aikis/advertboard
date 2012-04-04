require 'test_helper'

class UserAccessTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "user browse all" do

    post_via_redirect user_session_path, :user => { :email => users(:moder).email, :password => "13151725"}
    assert_equal root_path, path

    get "/admin"
    # assert_response :redirect
    assert_response :success
    get "/adverts/new"
    # assert_response :redirect
    assert_response :success
    get "/adverts/#{adverts(:one).id}/edit"
    # assert_response :redirect
    assert_response :success
    get "/adverts/#{adverts(:two).id}/edit"
    # assert_response :redirect
    assert_response :success
    assert_not_nil assigns(:advert)
    get "/users/edit"
    # assert_response :redirect
    assert_response :success
    get "/admin/user/#{users(:user).id}/edit"
    assert_response :redirect
    # assert_response :success
  end
end
