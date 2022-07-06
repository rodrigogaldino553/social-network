class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    !@user.has_role?(:unreviewd) || @user.has_role?(:admin)
    #o @user é o current_user e nao o user q esta sendo exibido
    #ex: eu sou o current, quero o ver o perfil de joao
  end

end
