# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'トップページ', type: :system do
  describe 'トップページの表示' do
    scenario 'ログイン画面へのリンクが表示されていること' do
      visit root_path
      expect(page).to have_link '講師としてログイン'
      expect(page).to have_link '受講生としてログイン'

      click_on('講師としてログイン')
      expect(page).to have_current_path new_teacher_session_path

      visit root_path
      click_on('受講生としてログイン')
      expect(page).to have_current_path new_student_session_path
    end
  end
end
