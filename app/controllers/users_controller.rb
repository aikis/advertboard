class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show ]
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

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Advert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = Advert.find(params[:id])
    user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end