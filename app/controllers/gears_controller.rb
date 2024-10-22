class GearsController < ApplicationController
  def for_brand
    @gears = Gear.where(brand_id: params[:brand_id])
    render json: { gears: @gears }
  end

  def by_brand_and_type
    brand_id = params[:brand_id]
    gear_type = params[:gear_type]
    puts "gears_controller#by_brand_and_type: brand_id=#{brand_id}, gear_type=#{gear_type}"
    gears = Gear.where(brand_id: brand_id, gear_type: gear_type)
    render json: gears
  end
end
