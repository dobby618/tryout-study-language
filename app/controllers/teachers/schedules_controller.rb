# frozen_string_literal: true

module Teachers
  class SchedulesController < ApplicationController
    def edit
      @form = Schedules::Form.new(params[:start_date], current_teacher)
    end

    def update
      @form = Schedules::Form.new(params[:start_date], current_teacher)
      @form.save(schedule_params)
      redirect_to edit_teachers_schedules_url(start_date: params[:start_date]),
                  notice: t('controllers.update.success', resource: Schedule.model_name.human)
    end

    private

      def schedule_params
        params.require(:schedules)
      end
  end
end
