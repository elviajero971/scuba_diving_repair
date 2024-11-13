class Gear < ApplicationRecord
  belongs_to :brand
  has_many :services, dependent: :destroy
  has_many :user_gears
  has_many :users, through: :user_gears

  enum gear_type: { :regulator => 0, :bcd => 1 }
  validates :name, presence: true, uniqueness: true
end
