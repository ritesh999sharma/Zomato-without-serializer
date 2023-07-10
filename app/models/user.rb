class User < ApplicationRecord
	has_many :restaurants, dependent: :destroy
	has_one :cart, dependent: :destroy
	has_many :orders

  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "should not contain numbers & symbol" }
	validates :user_type, presence: true, inclusion: { in: %w[OWNER owner customer CUSTOMER] }
	validates :email, presence: true, uniqueness: true, format: { with:  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
message: " wrong email format "}
	validates :password, presence: true, length: { in: 6..15, message: "password must be 6-15 character" }

end
