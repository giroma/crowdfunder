class User < ActiveRecord::Base
  has_secure_password

  has_many :pledges
  has_many :projects
  has_many :comments
  has_many :owner_updates
  has_many :claims

  validates :password, length: { minimum: 1 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true
end
