class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    # now it cant edit his avatar
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :name, :description])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :description])
  end

  def after_sign_in_path_for(resource)
    #if current_user # when uses authorization # .has_role?(:admin)
      #dashboard_path
      # check if user avatar is nil, and set a default o it
      # if action_name == "create" && !resource.avatar.attached?
        # user.avatar is gone, set default here
      # end
      # binding.pry
    root_path
    #elsif current_user # when uses authorization # .has_role?(:student)
    #  root_path
   #end
  end
end
