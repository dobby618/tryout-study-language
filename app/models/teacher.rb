# frozen_string_literal: true

class Teacher < ApplicationRecord
  include AvatarUploader::Attachment(:avatar)
  devise :database_authenticatable, :validatable

  has_many :teaching, dependent: :destroy
  has_many :teaching_languages, through: :teaching, source: :language
  has_many :schedules, dependent: :destroy

  with_options on: :update do
    validates :name, presence: true
    validates :avatar, presence: true
    validates :profile, presence: true
    validates :teaching_language_ids, presence: true
  end
end
