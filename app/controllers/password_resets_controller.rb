class PasswordResetsController < ApplicationController
  before_action :get_user, only: %w[edit update]
  before_action :valid_user, only: %w[edit update]
  before_action :check_expiration, only: %w[edit update] # Case 1: reset expired

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      message = 'Email sent with password reset instructions.'
      flash[:info] = message
      redirect_to root_url
    else
      message = 'Email address not found.'
      flash[:danger] = message
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      # Case 3: password and password confirmation are empty
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      # Case 4: successful update
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = 'Password successfully reset.'
      redirect_to @user
    else
      # Case 2: new password invalid
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Retrieve the user using her/his email.
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # Check if password reset token has expired
  def check_expiration
    return unless @user.password_reset_expired?

    redirect_to new_password_reset_url
    message = 'Password reset has expired. Please renew your password reset request.'
    flash[:danger] = message
  end
end
