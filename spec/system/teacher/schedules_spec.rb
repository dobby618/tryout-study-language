# frozen_string_literal: true

require 'rails_helper'

RSpec.feature '講師スケジュールの登録', type: :system, js: true do
  background do
    create(:teacher, email: 'teacher@example.com', password: 'password')
  end

  describe 'スケジュール画面の表示' do
    let(:current_date) { Date.current }

    before do
      teacher_sign_in(email: 'teacher@example.com', password: 'password')
      visit edit_teachers_schedules_path
    end

    it '今日から1週間分の日付と 7:00-22:00 までの時間帯、日付と時間帯の総当たりのチェックボックスが表示される' do
      # 1週間分の日付が表示されること
      (current_date..current_date.since(6.days).to_date).each do |date|
        expect(page).to have_content(I18n.l(date, format: :schedule))
      end

      # 7:00-22:00 までの時間帯が表示されること
      (7..22).each do |hour|
        expect(page).to have_content("#{hour}:00")
      end

      # 日付と時間帯の総当たりのチェックボックスが表示されること
      expect(all('input[type=checkbox]').count).to eq 112 # 1週間.count * (7..22).count
    end
  end

  describe '次の週、前の週に移動できるリンク' do
    let(:current_date) { Date.current }

    before do
      teacher_sign_in(email: 'teacher@example.com', password: 'password')
      visit edit_teachers_schedules_path
    end

    it '次の週、前の週に移動できる' do
      expect(page).to have_link('次の週')
      click_on '次の週'
      next_week = current_date.since(7.days).to_date
      (next_week..next_week.since(6.days).to_date).each do |date|
        expect(page).to have_content(I18n.l(date, format: :schedule))
      end

      expect(page).to have_link('前の週')
      click_on '前の週'
      (current_date..current_date.since(6.days).to_date).each do |date|
        expect(page).to have_content(I18n.l(date, format: :schedule))
      end
    end
  end

  describe '講師スケジュールの登録処理' do
    let(:current_date) { Date.current }

    before do
      teacher_sign_in(email: 'teacher@example.com', password: 'password')
      visit edit_teachers_schedules_path
    end

    it '講師スケジュールを登録する、登録を取り消す' do
      # 全てのスケジュールにチェックを付ける
      (current_date..current_date.since(6.days).to_date).each do |date|
        (7..22).each do |hour|
          check "schedules[#{I18n.l(date, format: :system)}][#{hour}]"
        end
      end
      click_on '更新する'
      expect(Schedule.count).to eq 112 # 1週間.count * (7..22).count

      # チェックを外すして取り消す
      uncheck "schedules[#{I18n.l(current_date, format: :system)}][7]"
      click_on '更新する'
      expect(Schedule.count).to eq 111
    end
  end
end
