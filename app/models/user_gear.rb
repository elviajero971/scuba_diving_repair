class UserGear < ApplicationRecord
  belongs_to :user
  belongs_to :gear

  validates :user_id, presence: true
  validates :gear_id, presence: true
end
