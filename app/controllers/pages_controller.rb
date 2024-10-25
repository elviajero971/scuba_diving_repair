class PagesController < ApplicationController
  def home
    case current_user&.role
    when 'admin'
      redirect_to admin_root_path
    when 'client'
      redirect_to services_path
    else
      redirect_to new_user_session_path
    end
  end
end