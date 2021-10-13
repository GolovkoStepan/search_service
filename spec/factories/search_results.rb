# frozen_string_literal: true

FactoryBot.define do
  factory :search_result do
    association :search_phrase
    products { [] }
    created_at { Time.now }
  end
end
