# frozen_string_literal: true

class LoadProducts < ActiveInteraction::Base
  def execute
    SearchPhrase.all.each do |search_phrase|
      products = products_for_phrase(search_phrase.text)
      search_phrase.search_results.create(products: products)
    end
  end

  private

  # @return [Integer]
  def max_pages_to_load
    @max_pages_to_load ||= Settings.daily_data_load.max_pages_to_search
  end

  # @param [String] phrase
  # @return [Array<Integer>]
  def products_for_phrase(phrase)
    request_data(phrase).map { |data| fetch_products(data) }.flatten
  end

  # @param [String] phrase
  # @return [Array<Hash>]
  def request_data(phrase)
    (1..max_pages_to_load).map do |page_num|
      Services::WildberriesApi.search(phrase, page_num)
    end
  end

  # @param [Hash] data
  # @return [Array<Integer>]
  def fetch_products(data)
    data.dig(:data, :products)
  end
end
