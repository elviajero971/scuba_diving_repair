class Service < ApplicationRecord
  has_many :payments
  belongs_to :user
  belongs_to :gear

  enum service_type: { basic: 0, premium: 1 }
  enum status: { pending: 0, not_delivered: 1, delivered: 2, ongoing_maintenance: 3, ready_for_pick_up: 4, completed: 5 }
  enum payment_status: { not_paid: 0, paid: 1 }

  validates :user_id, :gear_id, :status, presence: true

  def translated_status
    I18n.t("activerecord.attributes.service.status.#{status}")
  end

  def translated_service_type
    return I18n.t("activerecord.attributes.service.service_type.unknown") if service_type.nil?
    I18n.t("activerecord.attributes.service.service_type.#{service_type}")
  end

  def translated_payment_status
    I18n.t("activerecord.attributes.service.payment_status.#{payment_status}")
  end

end

