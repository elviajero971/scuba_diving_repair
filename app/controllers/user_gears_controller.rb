class UserGearsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_gear, only: [:destroy]

  def index
    @user_gears = current_user.user_gears.includes(:gear)
  end

  def new
    @user_gear = UserGear.new
    @available_gears = Gear.all - current_user.gears
  end

  def create
    @user_gear = current_user.user_gears.build(user_gear_params)

    if @user_gear.save
      redirect_to user_gears_path, notice: t('user_gears.create.success')
    else
      render :new
    end
  end

  def destroy
    @user_gear.destroy
    redirect_to user_gears_path, notice: t('user_gears.destroy.success')
  end

  private

  def set_user_gear
    @user_gear = current_user.user_gears.find(params[:id])
  end

  def user_gear_params
    params.require(:user_gear).permit(:gear_id, :last_service_date)
  end
end
