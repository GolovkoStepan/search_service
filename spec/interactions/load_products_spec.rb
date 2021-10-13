# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoadProducts do
  subject { described_class.run }

  let(:products) { [123, 456, 789] }
  let(:api_response) { { data: { products: products } } }

  let!(:search_phrase) { create :search_phrase, text: 'macbook' }

  before { expect(Services::WildberriesApi).to receive(:search).and_return(api_response) }

  it 'should create search_result record' do
    expect { subject }.to change(SearchResult, :count).from(0).to(1)
    expect(SearchResult.last.search_phrase).to eq(search_phrase)
    expect(SearchResult.last.products).to match_array(products.map(&:to_s))
  end
end
