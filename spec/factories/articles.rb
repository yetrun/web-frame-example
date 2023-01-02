# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Article Title' }
    content { 'Article content' }
  end
end
