# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :feedbacks, as: :feedbackable, dependent: :destroy

  def feedbacks_from(owner_id:)
    feedbacks.where(owner_id: owner_id)
  end
end
