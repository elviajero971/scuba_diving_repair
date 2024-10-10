module Admin
  class BrandsController < BaseController
    def index
      @brands = Brand.all
    end
  end
end
