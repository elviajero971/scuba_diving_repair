class GearsController < ApplicationController
  def for_brand
    @gears = Gear.where(brand_id: params[:brand_id])
    render json: { gears: @gears }
  end
end
