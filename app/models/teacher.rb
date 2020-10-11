# frozen_string_literal: true

class Teacher < ApplicationRecord
  devise :database_authenticatable, :validatable
end
