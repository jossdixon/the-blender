class Loan < ApplicationRecord
  belongs_to :user
  has_many :loanees

  validates :weeks, presence: true

end
