class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    @record.has_role?(:approved) || (@user && @record.user == @user) || (@user && @user.has_role?(:admin))
  end

  def edit?
    @record.user == @user
  end

  def destroy?
    # ver como usar o user has_hole ou algum jeito pra esse current_user.admin
    @record.user == @user || @user.has_role?(:admin)
  end
end
