# frozen_string_literal: true

# == Schema Information
#
# Table name: search_results
#
#  id               :bigint           not null, primary key
#  products         :text             default([]), not null, is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  search_phrase_id :bigint
#
# Indexes
#
#  index_search_results_on_products          (products) USING gin
#  index_search_results_on_search_phrase_id  (search_phrase_id)

FactoryBot.define do
  factory :search_result do
    association :search_phrase
    products { [] }
    created_at { Time.now }
  end
end
