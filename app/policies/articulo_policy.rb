class ArticuloPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else

        scope.where(persona_id: user.persona_id)
      end
    end
  end

  def show?
    user.admin? || record.persona_id == user.persona_id
  end


  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
