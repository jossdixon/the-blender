class WeeklyPaymentsController < ApplicationController
  def index
    @weekly_payments = policy_scope(Weekly_Payment)
  end

  def new
    @weekly_payment = Weekly_Payment.new
    authorize @weekly_payment
  end

  def create
    @weekly_payment = Weekly_Payment.new(weekly_payment_params)
    authorize @weekly_payment
    @weekly_payment.save
  end

  private

  def weekly_payment_params
    params.require(:weekly_payment).permit(:loanee_id, :amount)
  end
end
