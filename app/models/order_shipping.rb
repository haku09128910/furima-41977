class OrderShipping
  include ActiveModel::Model  # ActiveModelを利用可能にする

  # 保存するデータの属性を定義
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  # バリデーション
  with_options presence: true do
    validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :phone_number
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
  
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }

  def save
    # return false unless valid?  # バリデーションエラーがあれば保存しない

    order = Order.create(user_id: user_id, item_id: item_id)

    ShippingAddress.create(
      order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, address: address, building: building, phone_number: phone_number
    )
  end
end