class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @item.user_id == current_user.id
      redirect_to root_path, alert: '出品者は購入できません'
    else
      @order_shipping = OrderShipping.new
    end
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      pay_item
      
      
      redirect_to root_path, notice: "購入が完了しました"
    else

      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    order = Order.last # 最新のOrderを取得
    @item_price = Item.find(order.item_id).price
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @item_price,  
      card: order_params[:token],    
      currency: 'jpy'                
    )
  end

  def redirect_if_sold_out
    redirect_to root_path, alert: 'この商品はすでに売り切れです。' if @item.order.present?
  end
end