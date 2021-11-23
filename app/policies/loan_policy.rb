class LoanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.profile.nil?
        scope.all
      else
        scope.where(user.id == loan.user_id)
      end
    end
  end

  def show?
    user_is_loan_officer? || user.id == loan.user_id
  end

  def create?
    user_is_loan_officer?
  end

  private

  def user_is_loan_officer?
    user.profile.nil?
  end
end
