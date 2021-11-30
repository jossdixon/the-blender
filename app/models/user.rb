class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :loans # loan officer
  has_many :loanees, through: :loans
  has_many :debts, class_name: 'Loanee' # borrower
  has_one :loan_groups, through: :loanees, source: :loans
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_label
    full_name
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def active_debt
    debts.first
  end


  include PgSearch::Model
  pg_search_scope :loan_search,
    against: [ :first_name, :last_name, :email],
    using: {
      tsearch: { prefix: true }
    }
end
