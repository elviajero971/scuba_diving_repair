module Admin
  class PaymentsController < BaseController
    def index
      @payments = Payment.all.includes(:service)
    end
  end
end