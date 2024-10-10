module Admin
  class ServicesController < BaseController
    def index
      @services = Service.all
    end
  end
end