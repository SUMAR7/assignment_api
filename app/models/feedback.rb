# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  validates :owner_id, presence: true
  validates :comment, presence: true

  belongs_to :feedbackable, polymorphic: true
end
