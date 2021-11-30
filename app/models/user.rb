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
    debts.active.first
  end

  def payment_ratio
    # [['Task', 'Hours per Day'],
    [['Paid', get_payments_amount],
    ['Not paid', get_total - get_payments_amount]]
  end

  def get_payments_amount
    payments_amount = 0
    unless active_debt.nil?
      active_debt.weekly_payments.each do |payment|
        payments_amount += payment.amount
      end
    else
      return payments_amount
    end
    return payments_amount
  end

  def get_total
    unless active_debt.nil?
      active_debt.total
    else
      return 0
    end
  end


  include PgSearch::Model
  pg_search_scope :loan_search,
    against: [ :first_name, :last_name, :email],
    using: {
      tsearch: { prefix: true }
    }
end
