# frozen_string_literal: true

require 'rails_helper'


RSpec.describe Click, type: :model do

  let(:valid_click) { build(:click) }

  describe 'validations' do
    it 'validates url_id is valid' do
      expect(valid_click.valid?).to be(true)
    end

    it 'validates browser is not null' do
      expect(valid_click.valid?).to be(true)
    end

    it 'validates platform is not null' do
      expect(valid_click.valid?).to be(true)
    end
  end
end
