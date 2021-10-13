# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  describe 'validations' do
    subject { build(:search_result) }

    it { should validate_presence_of(:products) }
  end
end
