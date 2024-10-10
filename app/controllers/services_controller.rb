class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show]

  def index
    @services = current_user.services.includes(:gear)
  end

  def show
    @product_premium = Product.find_by(product_type: :premium)
    @product_basic = Product.find_by(product_type: :basic)
  end

  def new
    @service = Service.new
    @brands = Brand.all
    @gears = Gear.none
  end

  def create
    @service = current_user.services.new(service_params)

    if @service.save
      redirect_to service_choose_payment_path(@service)
    else
      @brands = Brand.all
      @gears = Gear.where(brand_id: service_params[:brand_id])
      render :new
    end
  end

  private

  def set_service
    @service = current_user.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:gear_id, :status)
  end
end
