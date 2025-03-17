class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, only: [:edit, :update, ]
  def index
    @items = Item.order(created_at: :desc)
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

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "商品情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show

  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: '商品が削除されました。'
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_day_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless @item.user == current_user
      redirect_to action: :index
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end