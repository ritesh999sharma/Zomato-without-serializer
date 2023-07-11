class CartController < ApplicationController
	
	def create_cart
		if @current_user.user_type == 'customer' || @current_user.user_type == 'CUSTOMER' 
			cart = Cart.new(user_id: @current_user.id)
			if cart.save
				render json: cart, status: :created
			else
				render json: {error: cart.errors.full_messages}, status: :unprocessable_entity
			end
		else
			render json: {message: "you not CUTOMER"}
		end
	end

	def add_to_cart
		# byebug
		if @current_user.user_type == 'customer' || @current_user.user_type == 'CUSTOMER' 
			restaurant = Restaurant.find_by(id: params[:restaurant_id])

			if restaurant && (restaurant.status == 'open' || restaurant.status == 'OPEN')
				begin
					if @current_user.cart == nil
						raise "No Cart Created"
					end
					if params[:id]
						# byebug
						cart = @current_user.cart
						new_dish = Dish.find_by(id: params[:id])
						cart.dishes << new_dish

						render json: cart, status: :created
					else
						render json: {error: "can't find dish with given id"}, status: 400
					end
				rescue Exception => e
					render json: {error: "Create a cart first", message: e.to_s}
				end
			else
				render json: {message: "restaurant not open"} 
			end 
		else
			render json: {message: "you not CUSTOMER"}
		end
	end
	
	def dishes_buy
		# byebug
		if @current_user.user_type == 'customer' || @current_user.user_type == 'CUSTOMER' 
			@cart = current_cart
			@dishes = @cart.dishes
			@bill = generate_bill(@dishes)

  		render json: @bill

			@cart.dishes.destroy_all

		else
			render json: {message: "you not CUTOMER"}
		end
	end

	def cart_dish
		 dish = Cart.dishes.all
		 render json: dish
	end

	private

	def current_cart
		Cart.find_by(user_id: @current_user.id)
	end

	def generate_bill(dishes)
		total = dishes.sum(&:price)
		bill = "!!!!!--Bill Details--!!!!!\n"
		dishes.each do |dish|
			bill += "#{dish.name} - #{dish.price}\n"
		end
		bill += "Total: #{total}"
		return bill
	end
end
