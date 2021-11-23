class Loan < ApplicationRecord
  belongs_to :user
  has_many :loanees

  validates :due_by, presence: true
  validates :float, presence: true
  validates :instalments, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
  validates :weeks, presence: true

  enum status: { active: 0, closed: 1, late: 2, defaulted: 3 }

end
