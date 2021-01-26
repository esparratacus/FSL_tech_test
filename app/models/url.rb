# frozen_string_literal: true
require 'uri'

class Url < ApplicationRecord
  # scope :latest, -> {}
  validates_format_of :original_url, with: URI.regexp
  validates_length_of :short_url, {is: 5}
  validates_format_of :short_url, with: /\w{5}/
  validates_uniqueness_of :short_url
end
