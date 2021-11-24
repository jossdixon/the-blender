class Loan < ApplicationRecord
  belongs_to :user
  has_many :loanees
  accepts_nested_attributes_for :loanees

  validates :weeks, presence: true

end
