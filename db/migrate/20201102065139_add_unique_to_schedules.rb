# frozen_string_literal: true

class AddUniqueToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_index :schedules, [:teacher_id, :language_id, :start_at], unique: true
  end
end
