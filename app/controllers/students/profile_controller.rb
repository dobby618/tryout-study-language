# frozen_string_literal: true

module Students
  class ProfileController < ApplicationController
    before_action :set_teacher

    def show
    end

    private

      def set_teacher
        @student = current_student
      end
  end
end
