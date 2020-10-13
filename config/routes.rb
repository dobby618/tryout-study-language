# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#show'

  constraints format: :html do
    # For Teacher
    devise_for :teachers
    namespace :teachers do
      root 'profile#show'
      resource :profile, controller: :profile, only: [:show, :edit, :update]
      resource :schedules, only: [:edit, :update]
    end

    # For Strudent

    # For Admin
    devise_for :admin_users, path: :admin
    namespace :admin do
      root 'teachers#index'
      resources :teachers
      resources :languages
    end
  end
end
