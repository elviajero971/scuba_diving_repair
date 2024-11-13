class Service < ApplicationRecord
  has_many :payments
  belongs_to :user
  belongs_to :gear

  enum service_type: { :basic => 0, :premium => 1, :unknown => 2 }
  enum status: { :pending => 0, :waiting_on_delivery => 1, :delivered => 2, :ongoing_maintenance => 3, :ready_for_pick_up => 4, :completed => 5 }
  enum payment_status: { :unpaid => 0, :paid => 1 }

  validates :user_id, :gear_id, :status, presence: true

end

