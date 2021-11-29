class LoaneesController < ApplicationController
  before_action :set_loanee, only: [:show, :edit, :update]
  def index
    @loanees = policy_scope(Loanee)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    # @loan = Loan.find(params[:loan_id])
    @loanee.update(loanee_params)
    # @loanee.loan = @loan
    authorize @loanee
    if @loanee.save
      redirect_to loan_path(@loanee.loan)
    else
      render :edit
    end
  end

  def show
  end

  private
  def set_loanee
    @loanee = Loanee.find(params[:id])
    authorize @loanee
  end

  def loanee_params
    params.require(:loanee).permit(:status, :total, :loan_id)
  end
end
