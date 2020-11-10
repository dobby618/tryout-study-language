# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'レッスン検索画面', type: :system do
  let(:burmese_language) { create(:language, name: 'ミャンマー語') }
  let(:thai_language)    { create(:language, name: 'タイ語') }
  let(:current_date) { Date.current }

  background do
    create(:student, email: 'student@example.com', password: 'password', name: 'あや')
  end

  describe 'レッスン検索画面の表示' do
    background do
      teacher1 = create(:teacher, :with_avatar, name: 'マイケル')
      teacher1.teaching_languages = [burmese_language, thai_language]
      teacher1.schedules.create(language: burmese_language, start_at: current_date.since(9.hours))
      teacher1.schedules.create(language: thai_language, start_at: current_date.since(9.hours))

      teacher2 = create(:teacher, :with_avatar, name: 'ジャスミン')
      teacher2.teaching_languages = [burmese_language]
      teacher2.schedules.create(language: burmese_language, start_at: current_date.since(9.hours))
    end

    scenario '指定した日時、言語にレッスン可能な講師が表示される' do
      visit students_lessons_path

      # ログインしていない場合、ログイン画面に遷移すること
      expect(page).to have_current_path new_student_session_path
      # ログインする
      student_sign_in(email: 'student@example.com', password: 'password',
                      redirect_back: students_lessons_path)

      # レッスン枠の空いてる先生が表示されること
      expect(page).to have_content 'マイケル 講師'
      expect(page).to have_content 'ジャスミン 講師'

      # 別の言語のレッスン一検索画面に遷移できること
      visit students_lessons_path(language: 'タイ語')
      expect(page).to have_content 'マイケル 講師'
      expect(page).not_to have_content 'ジャスミン 講師'
    end

    scenario 'レッスンの開始日程が2週間以内のみ検索できる' do
      student_sign_in(email: 'student@example.com', password: 'password')

      # 昨日以降は検索できない
      visit students_lessons_path(start_date: current_date.to_s)
      expect(page).not_to have_selector '.alert.alert-danger'
      visit students_lessons_path(start_date: current_date.yesterday.to_s)
      expect(page).to have_selector '.alert.alert-danger'

      # 2週間以降は検索できない
      visit students_lessons_path(start_date: current_date.since(13.days).to_s)
      expect(page).not_to have_selector '.alert.alert-danger'
      visit students_lessons_path(start_date: current_date.since(14.days).to_s)
      expect(page).to have_selector '.alert.alert-danger'
    end
  end
end
