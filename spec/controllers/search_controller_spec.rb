# frozen_string_literal: true

require 'rails_helper'

describe SearchController, type: :request do
  subject { JSON.parse(response.body).with_indifferent_access }

  let(:fake_interaction) { double('Fake Interaction') }
  let(:fake_result) { { payload: 'payload' } }
  let(:product) { '123' }

  context 'when outcome is valid' do
    before do
      expect(FindSearchResults).to receive(:run).with(**{ product: product }).and_return(fake_interaction)
      expect(fake_interaction).to receive(:valid?).and_return(true)
      expect(fake_interaction).to receive(:result).and_return(fake_result)
    end

    before { get search_path(product) }

    it 'returns status ok' do
      expect(response.status).to eq(200)
      expect(subject).to match(hash_including({ status: 'ok', data: fake_result }))
    end
  end

  context 'when outcome is not valid' do
    let(:product) { 'wrong_product' }

    before { get search_path(product) }

    it 'returns status error' do
      expect(response.status).to eq(200)
      expect(subject).to match(hash_including({ status: 'error', messages: ['Product is not a valid integer'] }))
    end
  end
end
