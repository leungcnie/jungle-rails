class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASS']
  
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
