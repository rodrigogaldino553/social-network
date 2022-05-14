class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def destroy?
    @record.user_id == @user.id ||
    @user.has_role?(:admin)
  end
end
