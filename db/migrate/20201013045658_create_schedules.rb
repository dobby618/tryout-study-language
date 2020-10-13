# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :teacher, null: false, foreign_key: true
      t.datetime :start_at

      t.timestamps
    end
  end
end
