class RestaurantsController < ApplicationController
	before_action :set_restaurant, only: [:destroy]

	def index
  		# @restaurants = Restaurant.all
  		@restaurants = Restaurant.paginate(page: params[:page], per_page: 10)
  		render json: @restaurants
  	end

  	def create
  		if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
  			@restaurant = @current_user.restaurants.new(restaurant_params) 
  			if @restaurant.save
  				render json: @restaurant, status: :created
  			else
  				render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
  			end
  		else
  			render json: {message: "you are not owner"}
  		end
  	end

  	def destroy
  		if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
  			if @restaurant
  				@restaurant.destroy
  				render json: { message: 'Restaurant and associated dishes deleted successfully' }
  			else
  				render json: { message: 'Restaurant not found' }
  			end
  		else
  			render json: {message: "you are not owner"}
  		end
  	end

	# def show
		# if @current_user.user_type == 'CUSTOMER' || @current_user.user_type == 'customer' 
	# 	@restaurant = Restaurant.find_by(name: params[:name])
	# 	render json: @restaurant
		# else
  		# 	render json: {message: "you are not owner"}
  		# end
	# end

	# def check_dishes_by_category

	# 	restaurant = Restaurant.find_by(name: params[:id])
	# 	category = params[:category]
	# 	dishes = restaurant.dishes.where(category: category)

	# 	render json: dishes
	#   rescue ActiveRecord::RecordNotFound
	# 	render json: { error: 'Restaurant not found' }, status: :not_found
	#   end

	def update
		begin
			@restaurant = Restaurant.find(params[:id])
		 	if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
				if @restaurant.update(restaurant_params)
					render json: @restaurant
				else
					render json: { error: @restaurant.errors.full_messages }, status: :unprocessable_entity
				end
			else
				render json: {message: "you are not owner"}
			end
		rescue
			render json: {message: "No data found with this id"}
		end
	end

	def check_dishes
		restaurant = Restaurant.find_by(name: params[:name])
		if restaurant
			dishes = restaurant.dishes.paginate(page: params[:page], per_page: 50)
			render json: dishes
		else
			render json: { error: 'Restaurant not found' }, status: :not_found
		end
	end

	private
	def restaurant_params
		params.permit(:name, :status, :user_id)
	end

	def set_restaurant
		@restaurant = Restaurant.find_by(name: params[:name])
	end

end
