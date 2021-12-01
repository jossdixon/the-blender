class LoansController < ApplicationController
before_action :set_loan, only: [ :show ]
  def index
    @date = params[:on_date] ? Date.parse(params[:on_date]) : Date.today
    @loans = policy_scope(Loan)
    @loans_today = get_today_payments(@loans, @date)
    @amounts = get_expected_amount(@loans_today)
  end

  def show
    @progress =0
    @loan_total = 0
    @loan.loanees.each do |loanee|
      loanee.weekly_payments.each do |payment|
        @progress = @progress + payment.amount.to_f
      end
      @loan_total = @loan_total + loanee.total.to_f
    end
    @percentage = (@progress/@loan_total)*100
  end

  def new
    @loan = Loan.new
    3.times do
      @loan.loanees.build
    end
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

  def get_today_payments(loans, on_date = Date.today)
    loans_today = []
    loans.each do |loan|
      i = 1
      loan.weeks.times do
        if ((loan.start_date) + (i * 7)) == on_date
          loans_today << loan
          i = i + 1
        end
      end
    end
    loans_today
  end

  def get_expected_amount(loans)
    amounts = {
    actual_amount_total: 0,
    expected_amount_total:  0,
    }
    loans.each do |loan|
      expected_amount_group = 0
      actual_amount_group = 0
      loan.loanees.each do |loanee|
          expected_amount_group =  expected_amount_group + (loanee.total.to_f / loan.weeks)
          loanee.weekly_payments.each do |weekly_payment|
          if weekly_payment.created_at.strftime('%Y-%m-%d') == Date.today.strftime('%Y-%m-%d')
              actual_amount_group += + weekly_payment.amount.to_f
          end
        end
      end
      amounts[:actual_amount_total]= amounts[:actual_amount_total] + actual_amount_group
      amounts[:expected_amount_total]= amounts[:expected_amount_total] + expected_amount_group
    end
    amounts
  end

end
