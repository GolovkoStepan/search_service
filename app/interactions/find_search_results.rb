# frozen_string_literal: true

class FindSearchResults < ActiveInteraction::Base
  integer :product

  def execute
    all_by_product(product).map do |result|
      {
        phrase: result.phrase,
        date: result.date,
        position: result.position
      }
    end
  end

  private

  def all_by_product(product)
    SearchResult.joins(:search_phrase)
                .where('search_results.products @> ?', "{#{product}}")
                .select('search_phrases.text as phrase, search_results.created_at as date, ' \
                        "array_position(search_results.products, '#{product}') as position")
  end
end
