module Admin
  class GearsController < BaseController
    def index
      @gears = Gear.all
    end
  end
end
