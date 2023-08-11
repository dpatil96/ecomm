# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  after_update :set_age

  def set_age
    if birth_date.present?
      today = Date.today
      calculated_age = today.year - birth_date.year
      calculated_age -= 1 if today < birth_date + calculated_age.years

      # Update the age attribute only if it's different
      update(age: calculated_age) if age != calculated_age
    end
  end

end
