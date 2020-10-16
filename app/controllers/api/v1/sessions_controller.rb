class Api::V1::SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    # SafeNavigation
    ## This cop transforms usages of a method call safeguarded by a non `nil` check for the variable whose method is being called to safe navigation (`&.`).
    if @user&.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      render json: UserSerializer.new(@user)
    else
      render json: {
        error: 'Invalid Credentials'
      }
    end
  end

  def render_current_user
    if logged_in?
      render json: UserSerializer.new(current_user)
    else
      @user = User.new(email: '', password: '')
      render json: UserSerializer.new(@user)
    end
  end

  def destroy
    session.clear
    render json: {
      notice: 'Successfully logged out'
    }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(email: params[:session][:email])
  end
end
