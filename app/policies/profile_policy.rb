class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_is_loan_officer?
  end

  def create?
    user_is_loan_officer?
  end

  private

  def user_is_loan_officer?
    user.profile.nil?
  end

end
