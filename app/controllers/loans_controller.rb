class LoansController < ApplicationController
before_action :set_loan, only: [ :show ]
  def index
    @loans = policy_scope(Loan)
  end

  def show
  end

  def new
    @loan = Loan.new
    authorize @loan
  end

  def create
    @loan = Loan.new(loan_params)
    authorize @loan
    @loan.save
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
    authorize @loan
  end

  def loan_params
    params.require(:loan).permit(:due_by, :instalments, :start_date, :status, :weeks)
  end
end
