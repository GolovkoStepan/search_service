# frozen_string_literal: true

# == Schema Information
#
# Table name: search_phrases
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

require 'rails_helper'

RSpec.describe SearchPhrase, type: :model do
  describe 'validations' do
    subject { build(:search_phrase) }

    it { should validate_presence_of(:text) }
  end
end
