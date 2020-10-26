# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name }
    profile { Faker::String.random }

    trait :with_avatar do # 画像は毎回生成したくないので必要な時だけ設定してください。
      avatar { File.new(Rails.root.join('spec', 'fixtures', 'profile_image.jpg')) }
    end
  end
end
