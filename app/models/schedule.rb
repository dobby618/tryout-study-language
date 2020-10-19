# frozen_string_literal: true

class Schedule < ApplicationRecord
  SCHEDULABLE_HOUR_RANGE = (7..22).freeze

  belongs_to :teacher
end
