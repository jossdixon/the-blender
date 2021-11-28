class NotesController < ApplicationController
before_action :set_note, only: [ :show]
  def index
    @notes = policy_scope(Note)
    @profile = Profile.find(params[:profile_id])
  end

  def show
  end

  def new
    @note = Note.new
    @profile = Profile.find(params[:profile_id])
    authorize @note
  end

  def create
    @note = Note.new(loan_params)
    @profile = Profile.find(params[:profile_id])
    @note.profile = @profile
    authorize @note
    if @note.save
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
    authorize @note
  end

  def loan_params
    params.require(:note).permit(:content, :profile_id)
  end
end
