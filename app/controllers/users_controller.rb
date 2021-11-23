class UsersController < ApplicationController
  def new
    @user = User.new
    @user.profile.build
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, profile_attributes: [:village, :phone_number, :birthday, :join_date, :business_type])
  end
end
