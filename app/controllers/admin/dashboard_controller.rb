class Admin::DashboardController < ApplicationController
  def show
    @product = Product.count(:all)
    @category = Category.all.count(:all)
  end
end
