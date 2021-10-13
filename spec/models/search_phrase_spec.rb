# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchPhrase, type: :model do
  describe 'validations' do
    subject { build(:search_phrase) }

    it { should validate_presence_of(:text) }
  end
end
