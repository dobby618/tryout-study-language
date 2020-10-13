# frozen_string_literal: true

class Language < ApplicationRecord
  validates :name, presence: true
end
