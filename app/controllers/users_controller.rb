class UsersController < ApplicationController

	before_action :user, only: [:destroy]
	skip_before_action :authenticate_request, only: [:create, :login]

	def index
		@user = User.paginate(page: params[:page], per_page: 10)
		render json: @user
	end

	def show
		if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
			@user_type = params[:user_type]
			if @user_type == 'owner' || @user_type == 'OWNER'
				@owners = User.where(user_type: ['OWNER', 'owner'])
				render json: @owners
			elsif @user_type == 'customer' || @user_type == 'CUSTOMER'
				@customers = User.where(user_type: ['CUSTOMER', 'customer'])
				render json: @customers
			else
				render json: { error: 'Invalid user_type parameter' }, status: :unprocessable_entity
			end
		else
			render json: {message: "you are not owner"}
		end

	end

	def create
		@user =  User.new(user_params)
		if @user.save
			render json: @user, status: :created
		else
			render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
			if @user
				@user.destroy
				render json: { message: 'user deleted successfully' }
			else
				render json: { message: 'user not found' }
			end
		else
			render json: {message: "you are not owner"}
		end

	end


	def login
		@user = User.find_by(email: params[:email], password: params[:password])
		if @user
			token = jwt_encode(user_id: @user.id)
			render json: { token: token }, status: :ok
		else
			render json: { errors: "Invalid email password"}, staus: 	:unauthorized
		end
	end

	def search_dishes
		if @current_user.user_type == 'customer' || @current_user.user_type == 'CUSTOMER' 
			@dish = Restaurant.find_by(id: @current_user)
			@dish = @dish.dishes
			render json: @dish
		else
			render json: {message: "you are not customer"}
		end
	end

	private

	def user_params
		params.permit(:user_type, :name, :email, :password)
	end

	def user
		@user = User.find_by(name: params[:name])
	end
end
