class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    puts 'Webhook received call for method WebHooksController#stripe'
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, ENV['STRIPE_ENDPOINT_SECRET'])
    rescue JSON::ParserError => e
      Rails.logger.error "JSON::ParserError: #{e.message}"
      render json: { message: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "Stripe::SignatureVerificationError: #{e.message}"
      render json: { message: 'Invalid signature' }, status: 400
      return
    end

    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']
      payment = Payment.find_by(stripe_payment_id: session.payment_intent)
      puts "Payment updates status to paid"
      payment.update(status: :paid) if payment
    else
      # type code here
    end

    render json: { message: 'Success' }, status: 200
  end
end
