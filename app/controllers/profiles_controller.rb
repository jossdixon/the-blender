class ProfilesController < ApplicationController
before_action :set_profile, only: [:show]
  def index
    if params[:query].present?
      @profiles = Profile.global_search(params[:query])
      authorize @profiles
    else
      @profiles = Profile.all
      authorize @profiles
    end
  end

  def show
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    authorize @profile
    @profile.save
  end

  private

  def profile_params
    params.require(:profile).permit(village, phone_number, birthday, join_date, business_type, user_id)
  end

  def set_profile
    @profile = Profile.find(params[:id])
    authorize @profile
  end
end
