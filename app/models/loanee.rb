class Loanee < ApplicationRecord
  belongs_to :user
  belongs_to :loan

  validates :total, presence: true
end
