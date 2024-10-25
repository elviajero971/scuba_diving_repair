class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :services, dependent: :destroy

  has_many :user_gears
  has_many :gears, through: :user_gears
  has_many :payments, through: :services

  enum role: { client: 0, admin: 1 }
end
