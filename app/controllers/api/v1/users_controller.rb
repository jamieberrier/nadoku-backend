class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      render json: UserSerializer.new(@user), status: :created
    else
      render_with_error(@user)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@users)
    else
      render_with_error(@user)
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def render_with_error(user)
    render json: {
      errors: user.errors.full_messages
    }, status: :unprocessable_entity
  end
end
