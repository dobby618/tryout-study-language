# frozen_string_literal: true

require 'rails_helper'

RSpec.feature '受講生のユーザ登録', type: :system do
  background do
    visit new_student_registration_path
  end

  describe '受講生のユーザ登録' do
    context '入力内容が有効な場合' do
      scenario '登録に成功し、受講生プロフィール画面を表示する' do
        fill_in 'メールアドレス', with: 'student@example.com'
        fill_in '名前', with: 'あや'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
  
        click_on 'Sign up'
  
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content 'student@example.com'
        expect(page).to have_content 'あや'
      end
    end

    context '入力内容が無効な場合' do
      scenario '登録に失敗し、入力フォームにエラーメッセージを表示する' do
        click_on 'Sign up'

        expect(page).to have_content '3 件のエラーにより保存できませんでした'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end
  end
end
