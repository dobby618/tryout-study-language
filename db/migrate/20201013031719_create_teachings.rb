# frozen_string_literal: true

class CreateTeachings < ActiveRecord::Migration[6.0]
  def change
    create_table :teachings do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
