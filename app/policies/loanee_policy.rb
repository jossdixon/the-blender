class LoaneePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user_is_loan_officer?
  end

  def edit?
    user_is_loan_officer?
  end

  def show?
    user_is_loan_officer?
  end
  private

  def user_is_loan_officer?
    user.profile.nil?
  end
end
