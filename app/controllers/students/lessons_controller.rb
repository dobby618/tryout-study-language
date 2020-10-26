# frozen_string_literal: true

module Students
  class LessonsController < ApplicationController
    before_action :set_language
    before_action :set_start_date
    before_action :start_date_within_two_weeks

    def index # rubocop:disable Metrics/AbcSize
      @schedules = {}.tap do |hash|
        Schedule.includes(:teacher)
                .where(language_id: @language.id, start_at: @start_date.all_day).each do |schedule|
          hash[l(schedule.start_at, format: :only_hour)] ||= []
          hash[l(schedule.start_at, format: :only_hour)] << schedule.teacher
        end
      end

      @languages = Language.all
      today = Date.current
      @dates = (today..today.since(13.days).to_date).map { |date| l(date, format: :system) }
    end

    private

      def set_language
        @language =
          if params[:language].blank?
            Language.first
          else
            Language.find_by!(name: params[:language])
          end
      end

      def set_start_date
        start_date = params[:start_date]
        @start_date = valid_date?(start_date) ? start_date.to_date : default_lesson_date
      end

      def start_date_within_two_weeks
        return if Date.current <= @start_date && @start_date <= Date.current.since(13.days).to_date

        flash.now[:alert] = '2週間以内の日付で検索してください。2週間以内の日付以外の場合は本日の日付で検索されます。'
        @start_date = default_lesson_date
      end

      def valid_date?(start_date)
        year, month, day = start_date.split('-').map(&:to_i)
        Date.valid_date?(year, month, day)
      rescue StandardError
        false
      end

      def default_lesson_date
        Date.current
      end
  end
end
