# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FindSearchResults do
  subject { described_class.run(product: product) }

  let(:phrase) { 'macbook' }

  let!(:search_phrase) { create :search_phrase, text: phrase }
  let!(:search_results) do
    [
      create(:search_result, search_phrase: search_phrase, created_at: Time.now, products: [123, 456, 789]),
      create(:search_result, search_phrase: search_phrase, created_at: Time.now + 1.day, products: [345, 333, 544]),
      create(:search_result, search_phrase: search_phrase, created_at: Time.now + 2.day, products: [335, 123, 553])
    ]
  end
  let(:result) do
    [
      {
        phrase: search_results.first&.search_phrase&.text,
        date: search_results.first&.created_at,
        position: 1
      },
      {
        phrase: search_results.last&.search_phrase&.text,
        date: search_results.last&.created_at,
        position: 2
      }
    ]
  end

  context 'when arg is valid' do
    let(:product) { 123 }

    it 'return valid outcome' do
      expect(subject).to be_valid
      expect(subject.result.count).to eq(2)
      expect(subject.result).to match_array(result)
    end
  end

  context 'when aeg is not valid' do
    let(:product) { 'product' }

    it 'return invalid outcome' do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.to_sentence).to eq('Product is not a valid integer')
    end
  end
end
