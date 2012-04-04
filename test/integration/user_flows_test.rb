require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :adverts
 
  test "login and logout all type users" do
    # User-admin logs in
    admin = login :admin
    # User logs in
    user = login :user
    # User-moderator logs in
    moder = login :moder
    # Non-login user
    nouser = login

    admin.reset!
    user.reset!
    moder.reset!
    nouser.reset!
  end

  test "browse open site part" do
 
    admin = login :admin
    user = login :user
    moder = login :moder
    nouser = login

    # User-admin can browse site
    admin.browses_open_part
    # User can browse site as well
    user.browses_open_part
    # User-moderator can browse site as well
    moder.browses_open_part
    # Non user browse site
    nouser.browses_open_part

    admin.reset!
    user.reset!
    moder.reset!
    nouser.reset!
  end
 
  test "browse private site part" do
 
    admin = login :admin
    user = login :user
    moder = login :moder
    nouser = login

    # User can browse site as well
    user.browses_protected_part_under_user
    # User-admin can browse site
    admin.browses_protected_part_under_admin
    # User-moderator can browse site as well
    moder.browses_protected_part_under_moderator
    # Non user browse site
    nouser.browses_protected_part_under_unauthorised
  end

  private
 
    module CustomDsl

      def browses_open_part
        get "/"
        assert_response :success
        assert assigns(:adverts)
        get "/adverts"
        assert_response :success
        assert_not_nil assigns(:adverts)
        get "/users/#{users(:admin).id}"
        assert_response :success
        get "/adverts/#{adverts(:one).id}"
        assert_response :success
      end

      def browses_protected_part_under_admin
        get "/admin"
        assert_response :success
        get "/adverts/new"
        assert_response :success
        get "/adverts/#{adverts(:one).id}/edit"
        assert_response :success
        # assert_not_nil assigns(:advert)
        get "/adverts/#{adverts(:two).id}/edit"
        assert_response :success
        # assert_not_nil assigns(:advert)
        get "/users/edit"
        assert_response :success
        get "/admin/user/#{users(:user).id}/edit"
        assert_response :success
      end

      def browses_protected_part_under_moderator
        get "/admin/user/227792459/edit"
        assert_equal "/admin/user/227792459/edit", path
        assert_response :redirect
        get "/admin"
        assert_response :success
        get "/adverts/new"
        assert_response :success
        get "/adverts/#{adverts(:one).id}/edit"
        assert_response :success
        # assert_not_nil assigns(:advert)
        get "/adverts/#{adverts(:two).id}/edit"
        assert_response :success
        # assert_not_nil assigns(:advert)
        get "/users/edit"
        assert_response :success
      end

      def browses_protected_part_under_user
        get "/admin"
        assert_response :redirect
        get "/adverts/new"
        assert_response :success
        get "/adverts/#{adverts(:one).id}/edit"
        assert_response :redirect
        get "/adverts/#{adverts(:two).id}/edit"
        assert_response :success
        assert_not_nil assigns(:advert)
        get "/users/edit"
        assert_response :success
        get "/admin/user/#{users(:user).id}/edit"
        assert_response :redirect
      end

      def browses_protected_part_under_unauthorised
        get "/admin"
        assert_equal '/users/sign_in', path
        get "/adverts/new"
        assert_response :redirect
        get "/adverts/#{adverts(:one).id}/edit"
        assert_response :redirect
        get "/adverts/#{adverts(:two).id}/edit"
        assert_response :redirect
        get "/users/edit"
        assert_response :redirect
        get "/admin/user/#{users(:user).id}/edit"
        assert_response :redirect
      end
    end

    def login(user = nil)
      if user
        open_session do |sess|
          sess.extend(CustomDsl)
          sess.post_via_redirect user_session_path, :user => { :email => users(user).email, :password => "13151725"}
          assert_equal root_path, sess.path
        end
      else
        open_session do |sess|
          sess.extend(CustomDsl)
        end
      end
    end
end