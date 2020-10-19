# frozen_string_literal: true

%w[ミャンマー語 タイ語 ベトナム語 中国語].each do |language|
  Language.find_or_create_by!(name: language)
end
