# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'トップページ', type: :system, js: true do
  background do
    visit root_path
  end

  describe 'トップページの表示' do
    scenario 'ログイン画面へのリンクが表示されていること' do
      expect(page).to have_link '講師としてログイン'

      click_on('講師としてログイン')
      expect(page).to have_current_path new_teacher_session_path
    end
  end
end
