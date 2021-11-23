class WeeklyPayment < ApplicationRecord
  belongs_to :loanee

  validates :amount, presence: true
end
