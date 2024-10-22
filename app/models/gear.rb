class Gear < ApplicationRecord
  belongs_to :brand
  has_many :services, dependent: :destroy
  has_many :user_gears
  has_many :users, through: :user_gears

  enum gear_type: { regulator: 0, bcd: 1 }
  validates :name, presence: true, uniqueness: true

  def translated_gear_type
    I18n.t("activerecord.attributes.gear.gear_type.#{gear_type}")
  end
end
