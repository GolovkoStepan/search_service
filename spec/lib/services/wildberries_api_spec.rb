# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::WildberriesApi do
  subject { described_class.search(search_phrase, 1) }

  let(:search_phrase) { 'macbook' }
  let(:api_uri) do
    "#{URI.join(Settings.wildberries_api.url, Settings.wildberries_api.search_path)}?search=#{search_phrase}&page=1"
  end
  let(:products) do
    [
      16_865_237, 16_865_235, 16_865_233, 10_051_592, 16_865_242, 16_865_236, 12_403_168, 16_865_245,
      16_865_238, 16_865_243, 12_403_170, 16_865_244, 11_206_279, 16_865_234, 12_403_169, 11_759_779, 17_724_719,
      21_576_667, 11_206_280, 25_582_007, 11_759_780, 17_724_721, 21_279_224, 17_724_717, 18_509_615, 8_272_574,
      9_437_171, 19_063_067, 7_200_324, 19_952_335, 17_724_720, 8_455_574, 25_681_980, 9_437_149, 8_455_573,
      13_693_693, 17_724_718, 13_693_694, 9_437_179, 18_265_495, 25_681_979, 18_821_107, 18_163_520, 36_235_738,
      19_063_068, 25_681_982, 19_952_331, 35_828_837, 19_436_944, 19_686_776, 35_818_566, 12_399_918, 25_877_643,
      38_728_527, 19_896_912, 8_455_571, 15_008_291, 26_324_049, 19_436_943, 38_332_386, 25_681_978, 8_455_572,
      15_670_817, 16_443_642, 29_457_712, 12_399_913, 26_324_050, 19_436_946, 8_771_275, 18_837_141, 35_506_118,
      37_808_152, 25_961_665, 17_068_529, 19_436_945, 14_192_830, 19_898_585, 41_004_019, 26_558_705, 9_437_143,
      14_192_829, 21_652_287, 24_716_985, 12_403_167, 12_776_760, 19_436_948, 9_437_208, 33_494_089, 43_532_682,
      17_082_815, 9_437_172, 9_437_147, 23_857_633, 21_459_703, 16_440_520, 28_957_563, 18_197_159, 27_557_299,
      10_079_917, 41_041_048, 25_681_977, 32_356_333, 25_832_871, 10_079_886, 37_125_854, 18_821_110, 40_715_873,
      12_506_998, 10_395_512, 13_773_667
    ]
  end

  context 'when server is available' do
    before { stub_request(:get, api_uri).to_return(body: file_fixture('wildberries_api_search.json').read) }

    it 'will return array of products' do
      expect(subject.dig(:data, :products).class).to eq(Array)
      expect(subject.dig(:data, :products).first.class).to eq(Integer)
      expect(subject.dig(:data, :products)).to match_array(products)
    end
  end

  context 'when server is not available' do
    before { stub_request(:get, api_uri).to_return(body: '', status: 404) }

    it 'will return empty hash' do
      expect(subject.class).to eq(Hash)
      expect(subject).to eq({})
    end
  end
end
