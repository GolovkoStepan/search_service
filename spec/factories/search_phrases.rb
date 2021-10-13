# frozen_string_literal: true

# == Schema Information
#
# Table name: search_phrases
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

FactoryBot.define do
  factory :search_phrase do
    text { 'some_search_text' }
  end
end
