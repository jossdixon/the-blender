class LoaneesController < ApplicationController
  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @loanee = Loanee.find(params[:id])
    authorize @loanee
  end
end
