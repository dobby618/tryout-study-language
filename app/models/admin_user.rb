# frozen_string_literal: true

class AdminUser < ApplicationRecord
  devise :database_authenticatable, :validatable
end
