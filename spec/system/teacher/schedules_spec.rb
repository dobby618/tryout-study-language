# frozen_string_literal: true

require 'rails_helper'

RSpec.feature '講師スケジュールの登録', type: :system, js: true do
  background do
    create(:teacher, email: 'teacher@example.com', password: 'password')
    create(:language, name: 'ミャンマー語')
    create(:language, name: 'ベトナム語')
  end

  describe 'スケジュール画面の表示' do
    let(:current_date) { Date.current }

    before do
      visit edit_teachers_schedules_path
    end

    it '担当言語に合わせて今日から1週間分の日付と 7:00-22:00 までの時間帯、日付と時間帯の総当たりのチェックボックスが表示される' do
      # ログインしていない場合、ログインページに遷移すること
      expect(page).to have_current_path(new_teacher_session_path)
      # ログインする
      visit new_teacher_session_path
      fill_in 'メールアドレス', with: 'teacher@example.com'
      fill_in 'パスワード', with: 'password'
      click_on 'Log in'

      # 担当言語を設定していない場合、プロフィール編集画面に遷移すること
      expect(page).to have_current_path(edit_teachers_profile_path)
      expect(page).to have_content("レッスンスケジュールを登録するには#{Language.model_name.human}を１つ以上選択してください。")
      # 担当言語を選択肢保存する
      add_teaching_languages

      visit edit_teachers_schedules_path
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
      add_teaching_languages
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
      add_teaching_languages
      visit edit_teachers_schedules_path
    end

    it '講師が複数の言語のスケジュールを登録する、登録を取り消す' do
      # ミャンマー後のスケジュールを登録する
      expect(page).to have_select('language', selected: 'ミャンマー語')
      ## 全てのスケジュールにチェックを付ける
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

      # ベトナム語のスケジュールを登録する
      select 'ベトナム語', from: 'language'
      ## 全てのスケジュールにチェックを付ける
      (current_date..current_date.since(6.days).to_date).each do |date|
        (7..22).each do |hour|
          check "schedules[#{I18n.l(date, format: :system)}][#{hour}]"
        end
      end
      click_on '更新する'
      expect(Schedule.count).to eq 223 # ミャンマー語（111） + ベトナム語（112）

      # チェックを外すして取り消す
      uncheck "schedules[#{I18n.l(current_date, format: :system)}][7]"
      click_on '更新する'
      expect(Schedule.count).to eq 222 # ミャンマー語（111） + ベトナム語（111）
    end
  end

  ######
  # Methods
  ######
  def add_teaching_languages
    visit edit_teachers_profile_path
    check 'ミャンマー語'
    check 'ベトナム語'
    # 画像はテストで必要な時しか生成してなく、プロフィール変更には必要なので追加する
    attach_file 'プロフィール画像', Rails.root.join('spec', 'fixtures', 'profile_image.jpg').to_s
    click_on 'Save'
  end
end
