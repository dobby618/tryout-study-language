# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    teacher
    start_at { Time.current }
  end
end
