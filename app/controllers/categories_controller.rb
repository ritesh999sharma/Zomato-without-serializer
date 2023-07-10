class CategoriesController < ApplicationController

	def index
		# @category = Category.all
		@category = Category.paginate(page: params[:page], per_page: 4)
		render json: @category
	end

	def show
		category = Category.find_by(name: params[:name]) 
		dishes = category.dishes
		render json: dishes  	    
		send

	end
