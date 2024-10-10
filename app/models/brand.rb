class Brand < ApplicationRecord
  has_many :gears, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
