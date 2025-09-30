class HistorialPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
