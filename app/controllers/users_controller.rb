class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_profile
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to profiles_path
    else
      raise
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, profile_attributes: [:village, :phone_number, :birthday, :join_date, :business_type, :birthday])
  end
end
