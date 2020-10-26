# frozen_string_literal: true

class Schedule < ApplicationRecord
  SCHEDULABLE_HOUR_RANGE = (7..22).freeze

  belongs_to :teacher
  belongs_to :language

  validates :start_at, uniqueness: { scope: [:teacher_id, :language_id] }
end
