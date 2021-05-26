class LineItemsController < ApplicationController
  def index
    @carts = Cart.all

    @order_item = current_order.order_items.new
  end

  def show
    @cart = Cart.find(params[:id])
  end
end
