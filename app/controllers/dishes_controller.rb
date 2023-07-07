class DishesController < ApplicationController

  def index
    @dish = Dish.all
    render json: @dish
  end
	 
  def create
    @dish = Dish.new(dish_params)
    if @dish.save

      render json: @dish
    else
      render :new
    end
  end


  def show
    @dish = Dish.find_by(name: params[:name]) 
    render json: @dish
  end

  private

  def dish_params
    params.permit(:name, :price, :category_id, :user_id, :restaurant_id)
  end
end
