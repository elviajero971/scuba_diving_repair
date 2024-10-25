module Admin
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!


    private

    def authenticate_admin!
      redirect_to root_path, alert: 'You must be admin to access this page.' unless current_user.admin?
    end
  end
end
