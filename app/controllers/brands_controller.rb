class BrandsController < ApplicationController
  def by_gear_type
    gear_type = params[:gear_type]
    brands = Brand.joins(:gears).where(gears: { gear_type: gear_type }).distinct
    puts "brands_controller#by_gear_type: gear_type=#{gear_type}, brands=#{brands.inspect}"
    render json: brands
  end
end
