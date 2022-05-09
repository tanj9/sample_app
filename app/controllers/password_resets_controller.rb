class PasswordResetsController < ApplicationController
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
      flash.now[:danger] = message
      render 'new'
    end
  end

  def edit
  end
end
