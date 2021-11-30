class Loan < ApplicationRecord
  belongs_to :user
  has_many :loanees, dependent: :destroy
  accepts_nested_attributes_for :loanees

  validates :weeks, presence: true

  def actual_amount_group
    actual_amount_group = 0
    self.loanees.each do |loanee|
      loanee.weekly_payments.each do |weekly_payment|
        if weekly_payment.created_at.strftime('%Y-%m-%d') == Date.today.strftime('%Y-%m-%d')
            actual_amount_group= actual_amount_group + weekly_payment.amount
        end
      end
    end
    actual_amount_group
  end

  def expected_amount_group
    expected_amount_group = 0
    self.loanees.each do |loanee|
      expected_amount_group= expected_amount_group + (loanee.total / self.weeks)
    end
    expected_amount_group
  end
end
