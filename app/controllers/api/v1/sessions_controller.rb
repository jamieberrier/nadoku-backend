class Api::V1::SessionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    password = params[:session][:password]
    # SafeNavigation
    ## This cop transforms usages of a method call safeguarded by a non `nil` check for the variable whose method is being called to safe navigation (`&.`).
    if @user&.authenticate(password)
      log_in_user
    elsif @user
      check_if_password_blank(password)
    elsif @user.nil?
      check_if_email_blank(params[:session][:email], password)
    end
  end

  def render_current_user
    if logged_in?
      render json: UserSerializer.new(current_user), status: :ok
    else
      @user = User.new(email: '', username: '', password: '')
      render json: UserSerializer.new(@user), status: :ok
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

  def log_in_user
    session[:user_id] = @user.id
    render json: UserSerializer.new(@user), status: :ok
  end

  def check_if_password_blank(password)
    if password.blank?
      render_with_error('Please Enter Password')
    else
      render_with_error('Invalid Password')
    end
  end

  def check_if_email_blank(email, password)
    if email.blank? && password.blank?
      render_with_error('Please Enter Email and Password')
    elsif email.blank?
      render_with_error('Please Enter Email')
    else
      render_with_error('Invalid Email')
    end
  end

  def render_with_error(message)
    render json: { error: message }, status: 422
  end
end
