# frozen_string_literal: true

require 'rails_helper'

RSpec.feature '受講生プロフィール画面', type: :system do
  background do
    create(:student, email: 'student@example.com', password: 'password', name: 'あや')
    visit students_root_path
  end

  describe '受講生プロフィール画面の表示' do
    scenario '受講生のプロフィールが表示される' do
      # ログインしていない場合、ログイン画面に遷移すること
      expect(page).to have_current_path new_student_session_path
      # ログインする
      student_sign_in(email: 'student@example.com', password: 'password')

      expect(page).to have_content 'student@example.com'
      expect(page).to have_content 'あや'
    end
  end
end
