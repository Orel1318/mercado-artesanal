class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: [ :index ]
   def index
      @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.new
  end

  def edit
  end

  def update
    @product.update(product_params)
    redirect_to my_products_path(@product)
  end

  def destroy
    @product.destroy
    redirect_to my_products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
