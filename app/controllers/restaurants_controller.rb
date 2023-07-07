class RestaurantsController < ApplicationController
	  # before_action :set_restaurant,only: [:show, :update, :destroy]

 
  
  def index
  	@restaurants = Restaurant.all
  	render json: @restaurants
		# byebug
  end
  
	def create
		@restaurant = @current_user.restaurants.new(restaurant_params) 
		if @restaurant.save
			render json: @restaurant, status: :created
		else
			render json: { errors: @restaurant.errors.full_messages },
			status: :unproccessable_entity
		end
	end

	def show
		# byebug
		@restaurant = Restaurant.find_by(name: params[:name]) 
		render json: @restaurant
	end

   private
			def restaurant_params
				params.permit(:name, :open_time, :close_time)
			end 

end
