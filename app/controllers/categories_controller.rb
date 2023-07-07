class CategoriesController < ApplicationController

	def index
		@category = Category.all
		render json: @category
	end

	def show
   category = Category.find_by("name LIKE ? ", "%#{params[:name]}") 
  	 
  	dishes = category.dishes

  	  render json: dishes  	    
  end
 
end
