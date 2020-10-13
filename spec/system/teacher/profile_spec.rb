# frozen_string_literal: true

require 'rails_helper'

RSpec.feature '講師プロフィールページ', type: :system, js: true do
  background do
    create(:admin_user, email: 'admin@example.com', password: 'password')
    admin_sign_in(email: 'admin@example.com', password: 'password')

    # Create teacher
    visit new_admin_teacher_path
    fill_in 'メールアドレス', with: 'teacher@example.com'
    fill_in 'パスワード', with: 'password'
    click_on '登録する'
    expect(page).to have_content('Teacherを作成しました。')
  end

  describe '講師プロフィールの更新' do
    background do
      teacher_sign_in(email: 'teacher@example.com', password: 'password')
    end

    context '入力内容が有効な場合' do
      scenario '更新に成功し、講師プロフィールページを表示する' do
        visit edit_teachers_profile_path

        expect(page).to have_field 'メールアドレス', with: 'teacher@example.com'

        fill_in 'メールアドレス', with: 'changed_teacher@example.com'
        fill_in '名前', with: '太郎'
        fill_in '自己紹介', with: '初めまして。地元はタイでいまは〇〇大学に通って日本語を勉強しています。'
        attach_file 'プロフィール画像', Rails.root.join('spec', 'fixtures', 'profile_image.jpg').to_s

        click_on 'Save'

        expect(page).to have_current_path teachers_profile_path
        expect(page).to have_content '講師を更新しました'
        expect(page).to have_content 'changed_teacher@example.com'
        expect(page).to have_content '太郎'
        expect(page).to have_selector 'img.card-img-top'
        expect(page).to have_content '初めまして。地元はタイでいまは〇〇大学に通って日本語を勉強しています。'
      end
    end

    context '入力内容が無効な場合' do
      scenario '更新に失敗し、入力フォームにエラーメッセージを表示する' do
        visit edit_teachers_profile_path

        expect(page).to have_field 'メールアドレス', with: 'teacher@example.com'

        fill_in 'メールアドレス', with: ''
        fill_in '名前', with: ''
        fill_in '自己紹介', with: ''
        # attach_file 'プロフィール画像', '' # 画像を設定してないという意図を表したい

        click_on 'Save'

        expect(page).to have_content '4 件のエラーにより保存できませんでした'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'プロフィール画像を入力してください'
        expect(page).to have_content '自己紹介を入力してください'
      end
    end
  end
end
