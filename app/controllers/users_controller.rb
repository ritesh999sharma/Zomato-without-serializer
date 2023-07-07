class UsersController < ApplicationController
		# include JsonWebToken

	skip_before_action :authenticate_request, only: [:create, :login]
	# before_action :set_user, only: [:show, :destroy]

	def index
		# @users = User.all
		# render json: @users, status: :ok
	end

	def show
		# render json: @user, status: :ok
	end

	def create
		# byebug
		@user =  User.new(user_params)
		if @user.save
			render json: @user, status: :created
		else
			render json: { errors: @user.errors.full_messages },
			status: :unproccessable_entity
		end
	end

	# def update
	# 	@user = User.find(params[:id])
	# 	unless @user.update(user_params)
	# 		render json: { errors: @user.errors.full_messages},
	# 		status: :unproccessable_entity
	# 	end 
	# end

	def login
		@user = User.find_by(email: params[:email], password: params[:password])
		if @user
			token = jwt_encode(user_id: @user.id)
			render json: { token: token }, status: :ok
		else
			render json: { errors: "Unauthorized"}, staus: 	:unauthorized
		end
	end

	# def destroy
	# 	@user.destroy
	# end

	def search_dishes
		@dish = Restaurant.find_by(id: @current_user)
		@dish = @dish.dishes
		render json: @dish
	end

	private
		def user_params
			params.permit(:name, :email, :password, :user_type)

		end

# 		def set_user
# 			@user = User.find(params[:id])
# 		end
end
