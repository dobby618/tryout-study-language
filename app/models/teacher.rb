# frozen_string_literal: true

class Teacher < ApplicationRecord
  include AvatarUploader::Attachment(:avatar)
  devise :database_authenticatable, :validatable

  with_options on: :update do
    validates :name, presence: true
    validates :avatar, presence: true
    validates :profile, presence: true
  end
end
