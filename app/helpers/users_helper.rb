module UsersHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar
    else
      asset_path('padrao.png')
    end
  end
end
