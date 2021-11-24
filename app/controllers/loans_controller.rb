class LoansController < ApplicationController
before_action :set_loan, only: [ :show ]
  def index
    @loans = policy_scope(Loan)
  end

  def show
  end

  def new
    @loan = Loan.new
    @loan.loanees.build
    authorize @loan
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.user = current_user
    authorize @loan
    if @loan.save
      redirect_to loan_path(@loan)
    else
      render :new
    end

  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
    authorize @loan
  end

  def loan_params
    params.require(:loan).permit(:weeks, :start_date, loanees_attributes: [ :user_id, :total, :status])
  end
end
