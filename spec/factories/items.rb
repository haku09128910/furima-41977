FactoryBot.define do
  factory :item do
    name { "テストアイテム" }
    description { "これはテスト用のアイテムです。" }
    category_id { 2 } # `1`は `---` のため `2` 以上に設定
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }
    price { 5000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample.jpg')), filename: 'sample.jpg', content_type: 'image/jpg')
    end
  end
end