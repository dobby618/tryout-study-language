# frozen_string_literal: true

class AddNameToStudents < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.column :name, :string, after: :email
    end
  end
end
