class Api::V1::SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      render json: UserSerializer.new(@user)
    else
      render json: {
        error: 'Invalid Credentials'
      }
    end
  end

  def get_current_user
    if logged_in?
      render json: UserSerializer.new(current_user)
    else
      render json: {
        error: 'No one logged in'
      }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(email: params[:session][:email])
  end
end
