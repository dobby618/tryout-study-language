# frozen_string_literal: true

class Teaching < ApplicationRecord
  belongs_to :teacher
  belongs_to :language
end
