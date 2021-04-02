FactoryBot.define do
  factory :post do
    museum_name { '国立美術館' }
    prefecture_id { Faker::Number.between(from: 2, to: 49) }
    rating { 4.5 }
    exhibition_title { '国際特別展' }
    text { 'テスト用の感想です' }
    impressive_artist { 'レオナルド・ダ・ヴィンチ' }
    impressive_work { 'テスト作品' }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
