# frozen_string_literal: true

class DeviseCreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.timestamps null: false
    end

    add_index :teachers, :email, unique: true
  end
end
