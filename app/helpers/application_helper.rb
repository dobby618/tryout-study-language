# frozen_string_literal: true

module ApplicationHelper
  def nl2br(str)
    return if str.blank?

    safe_join(str.split(/\R/), tag(:br))
  end
end
