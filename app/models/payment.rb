class Payment < ApplicationRecord
  belongs_to :service
  enum :status, { :pending => 0, :succeeded => 1, :failed => 2 }

  validates :stripe_payment_id, :amount, presence: true
end
