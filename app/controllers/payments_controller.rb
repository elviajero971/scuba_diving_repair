class PaymentsController < ApplicationController
  before_action :set_service, only: [:choose_payment, :create]
  before_action :authenticate_user!

  def index
    @payments = current_user.payments
  end

  def choose_payment
    puts "Payment choose_payment from PaymentsController#choose_payment"
    @product_premium = Product.find_by(product_type: :premium)
    @product_basic = Product.find_by(product_type: :basic)
  end

  def create
    puts "Payment create from PaymentsController#create"
    @product = Product.find_by(id: params[:product_id])

    if @product.nil?
      redirect_to @service, alert: 'Product not found.'
      return
    end

    # Create a Stripe Checkout Session
    session = Stripe::Checkout::Session.create({
                                                 metadata: {
                                                   service_id: @service.id,
                                                   product_id: @product.id
                                                 },
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                                price: @product.stripe_price_id,
                                                                quantity: 1
                                                              }],
                                                 mode: 'payment',
                                                 success_url: payment_success_url(@service, @product.id, session_id: '{CHECKOUT_SESSION_ID}'),
                                                 cancel_url: payment_cancel_url(@service, @product.id, session_id: '{CHECKOUT_SESSION_ID}')
                                               })

    # Create a Payment record associated with the service
    @service.payments.create!(
      stripe_payment_id: session.id,
      status: :pending,
      amount: @product.price
    )

    # Redirect the user to the Stripe Checkout page
    respond_to do |format|
      format.html { redirect_to session.url, allow_other_host: true }
    end
  end

  def success
    puts "Payment success from PaymentsController#success"
    puts "service_id: #{params[:service_id]}"
    puts "product_id: #{params[:product_id]}"
    @service = Service.find(params[:service_id])
    @product_type = Product.find_by(id: params[:product_id]).product_type.to_sym
    payment = @service.payments.find_by(stripe_payment_id: params[:session_id])

    puts "Payment updates status to succeeded"
    payment.update(status: :succeeded)
    @service.update(payment_status: :paid, status: :not_delivered, service_type: @product_type.to_sym)
  end

  def cancel
    @service = Service.find(params[:service_id])
    payment = @service.payments.find_by(stripe_payment_id: params[:session_id])

    payment.update(status: :failed)
  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def payment_success_url(service, product_id, session_id:)
    "https://#{ENV['ENV_HOST']}/services/#{service.id}/payment_success?session_id=#{session_id}&product_id=#{product_id}"
  end

  def payment_cancel_url(service, product_id, session_id:)
    "https://#{ENV['ENV_HOST']}/services/#{service.id}/payment_cancel?session_id=#{session_id}&product_id=#{product_id}"
  end
end
