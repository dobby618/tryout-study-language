# frozen_string_literal: true

class DeviseCreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.timestamps null: false
    end

    add_index :students, :email, unique: true
  end
end
