# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name }
  end
end
