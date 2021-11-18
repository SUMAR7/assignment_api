# frozen_string_literal: true

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :ip_address, presence: true

  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :feedbacks, as: :feedbackable, dependent: :destroy

  def average_rating
    ratings.average(:stars).round(2)
  end

  def feedbacks_from(owner_id:)
    feedbacks.where(owner_id: owner_id)
  end
end
