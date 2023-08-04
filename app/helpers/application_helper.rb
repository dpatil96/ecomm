# frozen_string_literal: true

module ApplicationHelper
    module ApplicationHelper
        def star_rating(rating)
          content_tag(:div, class: 'star-ratings') do
            rating.times do
              concat content_tag(:i, '', class: 'fas fa-star')
            end
            (5 - rating).times do
              concat content_tag(:i, '', class: 'fas fa-star-o')
            end
          end
        end
      end
      
end
