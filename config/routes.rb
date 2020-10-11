# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, path: :admin

  namespace :admin do
  end
end
