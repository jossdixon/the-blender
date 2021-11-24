class Loanee < ApplicationRecord
  belongs_to :user
  belongs_to :loan

  validates :total, presence: true
  validates :status, presence: true

  enum status: { active: 0, closed: 1, late: 2, defaulted: 3 }
end
