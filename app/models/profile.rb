class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo

  validates :village, presence: true
  validates :phone_number, presence: true
  validates :birthday, presence: true
  validates :join_date, presence: true
  validates :business_type, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :village, :business_type ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
