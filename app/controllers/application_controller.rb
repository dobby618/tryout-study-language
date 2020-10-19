# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

    def after_sign_in_path_for(resource)
      stored_location_for(resource) ||
        case resource
        when AdminUser
          admin_root_path
        when Teacher
          teachers_root_path
        else
          root_path
        end
    end
end
