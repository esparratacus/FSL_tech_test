# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original_url { "https://www.google.com" }
    short_url {"1F3ab"}
    clicks_count { 0 }
  end
end