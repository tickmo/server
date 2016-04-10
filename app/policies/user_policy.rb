class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    return true if user.admin?
    return true if record.id == user.id
  end

  def destroy?
    return true if user.admin?
    return true if record.id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
