class Category < ApplicationRecord
	has_many :dishes

	 validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "should not contain numbers & symbol" }
end
