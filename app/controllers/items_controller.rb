class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    # トップページの処理
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "商品を出品しました！" # 成功時はトップページへリダイレクト
    else
      render :new, status: :unprocessable_entity # 失敗時は出品ページを再表示
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_day_id, :image).merge(user_id: current_user.id)
  end
end