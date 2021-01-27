# frozen_string_literal: true

require 'rails_helper'


RSpec.describe Url, type: :model do
  let(:shortened_url) { build(:url) }
  let(:invalid_short_url) { build(:url, short_url: '?$ AS') }
  let(:no_short_url) { build(:url, short_url: nil) }

  describe 'validations' do
    context 'when the original url is valid' do
      it 'validates original URL is a valid URL' do
        expect(shortened_url.valid?).to be(true)
      end

      it 'validates that short_url has 5 characters' do
        expect(shortened_url.valid?).to be(true)
      end

      it 'validates that short_url is unique' do
        expect(shortened_url.valid?).to be(true)
      end

      it 'validates that shor_url can have upper case and lower case characters and can have numbers' do
        expect(shortened_url.valid?).to be(true)
      end
    end

  end
end
