# frozen_string_literal: true

class Product < ApplicationRecord
  paginates_per 4
  has_one_attached :main_image
  has_many :reviews

  has_many :cart_items

  validates :name, presence: true

  validates :name, confirmation: true

  validates :price, numericality: true

  validates :name, uniqueness: { case_sensitive: false }

  attribute :default_rating, :decimal, default: 4.0


  ratyrate_rateable 'quality'
end
