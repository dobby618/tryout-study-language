# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    name { Faker::Name.name }
    # avatar # 画像は毎回生成したくないので初期値を設定しない
    profile { Faker::String.random }
  end
end
