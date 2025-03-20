class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out

  def index
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      pay_item
      
      # binding.pry
      redirect_to root_path, notice: "購入が完了しました"
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: params[:price])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    order = Order.last # 最新のOrderを取得
    @item_price = Item.find(order.item_id).price
    Payjp.api_key = "sk_test_79b03f593759d5ff412c0d5f"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item_price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def redirect_if_sold_out
    redirect_to root_path, alert: 'この商品はすでに売り切れです。' if @item.order.present?
  end
end