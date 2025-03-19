class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  # before_action :redirect_if_sold_out

  def index
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)

    if @order_shipping.valid?
      @order_shipping.save
      redirect_to root_path, notice: "購入が完了しました"
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold_out
    redirect_to root_path, alert: 'この商品はすでに売り切れです。' if @item.order.present?
  end
end