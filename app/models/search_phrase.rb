# frozen_string_literal: true

# == Schema Information
#
# Table name: search_phrases
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class SearchPhrase < ApplicationRecord
  has_many :search_results

  validates :text, presence: true
end
