class Gear < ApplicationRecord
  belongs_to :brand
  has_many :services, dependent: :destroy

  enum gear_type: { regulator: 0 }
  validates :name, presence: true, uniqueness: true
end
