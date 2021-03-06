# frozen_string_literal: true
require 'uri'

class Url < ApplicationRecord
  has_many :clicks

  # scope :latest, -> {}
  validates_format_of :original_url, with: URI.regexp
  validates_length_of :short_url, {is: 5}
  validates_format_of :short_url, with: /\w{5}/
  validates_uniqueness_of :short_url

  before_validation :set_short_url, on: :create

  def set_short_url
    self[:short_url] = SecureRandom.alphanumeric(5)
  end
end
