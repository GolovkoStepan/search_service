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
#

class SearchResult < ApplicationRecord
  belongs_to :search_phrase

  validates :products, presence: true

  def self.all_by_product(product)
    joins(:search_phrase)
      .where('search_results.products @> ?', "{#{product}}")
      .select('search_phrases.text as phrase, search_results.created_at as date, ' \
              "array_position(search_results.products, '#{product}') as position")
  end
end
