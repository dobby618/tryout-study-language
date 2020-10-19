# frozen_string_literal: true

# 講師が空きスケジュールを登録するフォーム
module Teachers
  module Schedules
    class Form
      attr_reader :start_date, :current_teacher, :registered_start_datetimes

      def initialize(start_date, current_teacher)
        @start_date = valid_date?(start_date) ? start_date.to_date : default_schedule_date
        @current_teacher = current_teacher
        @registered_start_datetimes = registered_schedules(@start_date).pluck(:start_at)
      end

      # 聞きたいこと
      # テストいる？ E2E でやってるし要らないかな？
      def save(params)
        ApplicationRecord.transaction do
          params.each do |date, hours|
            hours.each do |hour, checked|
              start_at = to_datetime(date: date, hour: hour)
              update(start_at, checked)
            end
          end
        end
      end

      def checked_schedule?(date:, hour:)
        registered_start_datetimes.include?(to_datetime(date: date, hour: hour))
      end

      def one_week_days
        (start_date..start_date.since(6.days).to_date)
      end

      def next_week_date
        start_date.since(7.days).to_date.to_s
      end

      def last_week_date
        start_date.ago(7.days).to_date.to_s
      end

      def to_datetime(date:, hour:)
        Time.zone.parse("#{date} #{hour}:00:00")
      end

      private

        def default_schedule_date
          Date.current
        end

        def registered_schedules(start_date)
          current_teacher
            .schedules
            .where(start_at: start_date.beginning_of_day..start_date.since(6.days).end_of_day)
        end

        def valid_date?(start_date)
          year, month, day = start_date.split('-').map(&:to_i)
          Date.valid_date?(year, month, day)
        rescue StandardError
          false
        end

        def update(start_at, checked)
          if registered_start_datetimes.include?(start_at) && checked == '0' # 取り消し
            schedule = current_teacher.schedules.find_by!(start_at: start_at)
            schedule.destroy
          elsif checked == '1'
            current_teacher.schedules.find_or_create_by!(start_at: start_at)
          end
        end
    end
  end
end
