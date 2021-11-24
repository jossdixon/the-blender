class Loan < ApplicationRecord
  belongs_to :user
  has_many :loanees, dependent: :destroy
  accepts_nested_attributes_for :loanees

  validates :weeks, presence: true
end
