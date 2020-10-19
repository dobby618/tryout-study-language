# frozen_string_literal: true

module Teachers
  class SchedulesController < ApplicationController
    before_action :set_default_language, only: :edit
    before_action :set_language, only: :update

    def edit
      @form = Schedules::Form.new(params[:start_date], @language, current_teacher)
    end

    def update
      @form = Schedules::Form.new(params[:start_date], @language, current_teacher)

      @form.save(schedule_params)
      redirect_to edit_teachers_schedules_url(start_date: params[:start_date],
                                              language: @language.name),
                  notice: t('controllers.update.success', resource: Schedule.model_name.human)
    end

    private

      def schedule_params
        params.require(:schedules)
      end

      def set_language
        @language = current_teacher.teaching_languages.find_by!(name: params[:language])
      end

      def set_default_language
        @language = params[:language].present? ? set_language : default_language
      end

      def default_language
        language = current_teacher.teaching_languages.first
        if language.blank?
          message = "レッスンスケジュールを登録するには#{Language.model_name.human}を１つ以上選択してください。"
          redirect_to(edit_teachers_profile_url, alert: message) && return
        end
        language
      end
  end
end
