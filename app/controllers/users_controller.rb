class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    if params[:query].present?
      @users = policy_scope(User).loan_search(params[:query])
    else
      @users = User.all
      @users = policy_scope(User)
    end
  end

  def new
    @user = User.new
    @user.build_profile
    authorize @user
  end

  def show
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
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, profile_attributes: [:village, :phone_number, :birthday, :join_date, :business_type, :birthday, :photo])
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
