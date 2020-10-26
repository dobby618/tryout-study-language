# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    name { Faker::Name.name }
  end
end
