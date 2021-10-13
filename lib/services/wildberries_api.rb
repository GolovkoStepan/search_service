# frozen_string_literal: true

module Services
  class WildberriesApi
    class << self
      # @param [String] phrase
      # @param [Integer] page_number
      # @return [Hash]
      def search(phrase, page_number)
        with_any_errors do
          api_uri  = URI.join(Settings.wildberries_api.url, Settings.wildberries_api.search_path)
          params   = { search: phrase, page: page_number }
          response = RestClient.get(api_uri.to_s, { params: params })

          JSON.parse(response.body).with_indifferent_access
        end
      end

      private

      def with_any_errors
        yield
      rescue StandardError => e
        Rails.logger.error("WildberriesApi request failed, message: #{e.message}")
        {}
      end
    end
  end
end
