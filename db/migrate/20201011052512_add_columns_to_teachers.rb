# frozen_string_literal: true

class AddColumnsToTeachers < ActiveRecord::Migration[6.0]
  def change
    change_table :teachers, bulk: true do |t|
      t.column :name,        :string, after: :email
      t.column :avatar_data, :text,   after: :name
      t.column :profile,     :text,   after: :avatar_data
    end
  end
end
