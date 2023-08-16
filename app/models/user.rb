# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable\
  after_create :create_profile

  has_one :profile
  has_many :reviews
  has_one :cart
  has_many :cart_items
  has_one :order
  has_many :order_items, through: :order

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  def admin?
    role == 'admin'
  end

  def users_list?
    authorize :manager, :users_list?
  end

  private

  def create_profile
    build_profile.save
  end
end
