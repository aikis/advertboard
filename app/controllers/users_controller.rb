class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @json = @users.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/:id
  # GET /users/:id.json
  def show
    @user = User.find(params[:id])
    @json = @user.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end