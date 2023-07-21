# frozen_string_literal: true

class Product < ApplicationRecord
  paginates_per 2
  has_one_attached :main_image
  has_many :reviews

  has_many :cart_items

  validates :name, presence: true

  validates :name, confirmation: true

  validates :price, numericality: true

  validates :name, uniqueness: { case_sensitive: false }

  ratyrate_rateable 'quality'
end
