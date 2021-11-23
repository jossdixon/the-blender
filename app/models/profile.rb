class Profile < ApplicationRecord
  belongs_to :user

  validates :village, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true
  validates :join_date, presence: true
  validates :business_type, presence: true

end
