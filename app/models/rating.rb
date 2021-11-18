# frozen_string_literal: true

class Rating < ActiveRecord::Base
  validates :stars, numericality: { in: 1..5 }

  belongs_to :post
end
