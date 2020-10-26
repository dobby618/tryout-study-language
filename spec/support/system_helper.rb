# frozen_string_literal: true

module SystemHelper
  def admin_sign_in(email:, password:)
    visit new_admin_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Log in'

    expect(page).to have_content 'ログインしました。'
    expect(page).to have_current_path admin_root_path
  end

  def teacher_sign_in(email:, password:)
    visit new_teacher_session_path

    fill_in 'メールアドレス', with: email
    fill_in 'パスワード', with: password
    click_on 'Log in'

    expect(page).to have_content 'ログインしました。'
    expect(page).to have_current_path teachers_root_path
  end

  def student_sign_in(email:, password:, redirect_back: students_root_path)
    visit new_student_session_path

    fill_in 'メールアドレス', with: email
    fill_in 'パスワード', with: password
    click_on 'Log in'

    expect(page).to have_content 'ログインしました。'
    expect(page).to have_current_path redirect_back
  end
end
