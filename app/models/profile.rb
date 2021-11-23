class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo

  validates :village, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true
  validates :join_date, presence: true
  validates :business_type, presence: true

end
