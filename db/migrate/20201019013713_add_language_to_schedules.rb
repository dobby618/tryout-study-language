# frozen_string_literal: true

class AddLanguageToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_reference :schedules, :language, null: false, foreign_key: true, after: :teacher_id
  end
end
