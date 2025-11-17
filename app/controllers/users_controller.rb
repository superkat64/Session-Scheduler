class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 5, within: 10.minutes, only: :create, with: -> { redirect_to new_user_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts @user
    if @user.save!
      start_new_session_for @user
      redirect_to after_authentication_url
    else
      render new_user_path, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end