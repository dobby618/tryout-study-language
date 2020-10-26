# frozen_string_literal: true

%w[ミャンマー語 タイ語 ベトナム語 中国語].each do |language|
  Language.find_or_create_by!(name: language)
end

Teacher.create(
  email: 'teacher@example.com',
  password: 'password'
)
Teacher.create(
  email: 'teacher2@example.com',
  password: 'password'
)

Student.create(
  email: 'student@example.com',
  password: 'password'
)
Student.create(
  email: 'student2@example.com',
  password: 'password'
)
