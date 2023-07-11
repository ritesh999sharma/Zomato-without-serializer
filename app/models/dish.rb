  class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :cart, optional: true   
  belongs_to :restaurant

  validates :name, presence: true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "should not contain numbers & symbol" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
