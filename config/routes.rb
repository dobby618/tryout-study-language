# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :teachers
  devise_for :admin_users, path: :admin

  namespace :admin do
    root to: 'teachers#index'
    resources :teachers
  end
end
