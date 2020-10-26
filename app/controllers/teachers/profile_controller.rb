# frozen_string_literal: true

module Teachers
  class ProfileController < ApplicationController
    before_action :set_teacher

    def show
    end

    def edit
    end

    def update
      if @teacher.update(teacher_params)
        redirect_to teachers_root_url,
                    notice: t('controllers.update.success', resource: Teacher.model_name.human)
      else
        render :edit
      end
    end

    private

      def set_teacher
        @teacher = current_teacher
      end

      def teacher_params
        params.require(:teacher).permit(:email, :name, :avatar, :profile, teaching_language_ids: [])
      end
  end
end
