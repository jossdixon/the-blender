class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :loans # loan officer
  has_many :loanees
  has_many :loan_groups, through: :loanees, source: :loans
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
