# frozen_string_literal: true

class Student < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  validates :name, presence: true
end
