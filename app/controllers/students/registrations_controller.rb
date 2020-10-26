# frozen_string_literal: true

module Students
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      super
    end

    private

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      end
  end
end
