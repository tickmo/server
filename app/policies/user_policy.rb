class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    return true if user
  end

  def destroy?
    return true if user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
