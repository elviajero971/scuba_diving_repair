module Admin
  class UsersController < BaseController
    def index
      @users = User.client
    end

    def show
      @user = User.find(params[:id])

      @user_presenter = Admin::UserPresenter.new(@user)
    end
  end
end