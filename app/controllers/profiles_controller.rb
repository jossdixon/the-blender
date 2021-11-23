class ProfilesController < ApplicationController
  def index
    if params[:query].present?
      @profile = Profile.global_search(params[:query])
    else
    @profiles = Profile.all
    end
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
