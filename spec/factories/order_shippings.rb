FactoryBot.define do
  factory :order_shipping do
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { "東京都" }
    address { "1-1-1" }
    building { "マンション101" }
    phone_number { "09012345678" }
    # token { "tok_abcdefghijk00000000000000000" }
  end
end