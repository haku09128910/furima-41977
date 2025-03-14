class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions  

  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_day


  belongs_to :user  # 出品者（Userモデル）とのアソシエーション
  has_one_attached :image  # ActiveStorageを使う場合


  validates :name, :description, :price, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_day_id, :image, presence: true
  validates :category_id, :status_id, :shipping_fee_id, :prefecture_id, :delivery_day_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :price, numericality: { only_integer: true, message: "is not a number" }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "must be between ¥300 and ¥9,999,999" }
end