class DishesController < ApplicationController
  before_action :set_dishes, only: [:destroy]

  def index
    # @dish = Dish.all
    @dish = Dish.paginate(page: params[:page], per_page: 50)
    render json: @dish
  end

  def create
    if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
      # byebug
      @dish = Dish.new(dish_params)
      if @dish.save
        render json: @dish
      else
        render json: {message: "dish not created"}
      end
    else
      render json: {message: "you are not owner"}
    end
  end

  def show
    @dish = Dish.find_by(name: params[:name]) 
    render json: @dish
  end

  def update
    if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER'
      begin
      @dish = Dish.find_by(id: params[:id])
      if @dish.update(dish_params)
        render json: @dish
      else
        render json: { error: @dish.errors.full_messages }, status: :unprocessable_entity
      end
    rescue
       render json: {message: "id not found"}
     end
    else
      render json: {message: "you are not owner"}
    end
  end
  
  def destroy
   if @current_user.user_type == 'owner' || @current_user.user_type == 'OWNER' 
    if @dish 
      @dish.destroy
      render json: { message: 'dish deleted successfully' }
    else  
      render json: { message: 'dish not found '} 
    end
  else
    render json: {message: "you are not owner"}
  end
end

private

def dish_params
 params.permit(:name, :price, :category_id, :user_id, :restaurant_id)
end

def set_dishes
 @dish = Dish.find_by(name: params[:name])
end

end
