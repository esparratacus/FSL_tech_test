# frozen_string_literal: true

FactoryBot.define do
  factory :click do
    url
    browser { "Firefox" }
    platform {"linux"}
  end
end