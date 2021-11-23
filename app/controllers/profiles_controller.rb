class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.save
  end

  private

  def profile_params
    params.require(:profile).permit(village, phone_number, birthday, join_date, business_type)
  end
end
