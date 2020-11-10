# frozen_string_literal: true

FactoryBot.define do
  factory :schedule do
    teacher
    language
    start_at { I18n.l(Time.current, format: :truncate_by_hour) }
  end
end
