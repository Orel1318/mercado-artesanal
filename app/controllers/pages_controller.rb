class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")

    else
      @products = Product.limit(10)
    end
  end

  def my_sales
    @sales = current_user.sales
  end

  def my_products
    @products = current_user.products
  end
end
