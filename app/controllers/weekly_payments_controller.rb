class WeeklyPaymentsController < ApplicationController
  def index
    @weekly_payments = policy_scope(WeeklyPayment)
    @loanee = Loanee.find(params[:loanee_id])
  end

  def new
    @loanee = Loanee.find(params[:loanee_id])
    @weekly_payment = WeeklyPayment.new
    authorize @weekly_payment
  end

  def create
    @loanee = Loanee.find(params[:loanee_id])
    @weekly_payment = WeeklyPayment.new(weekly_payment_params)
    @weekly_payment.loanee = @loanee
    authorize @weekly_payment
    if @weekly_payment.save
      redirect_to loanee_weekly_payments_path
    else
      render :new
    end
  end

  private

  def weekly_payment_params
    params.require(:weekly_payment).permit(:loanee_id, :amount)
  end
end
