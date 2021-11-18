# frozen_string_literal: true

# Feedbacks controller
class FeedbacksController < BaseController
  def create
    resource = find_resource
    return not_found('invalid post or user id') if resource.nil?

    feedback = resource.feedbacks.build(feedback_params)

    if feedback.save
      build_response(serialize_response(feedback, resource))
    else
      build_response error_response(feedback), status: 422
    end
  end

  private

  def serialize_response(feedback, resource)
    JSON.generate(
      {
        success: true,
        data: resource.feedbacks_from(owner_id: feedback.owner_id).as_json
      }
    )
  end

  def feedback_params
    params[:feedback]&.slice(:comment, :owner_id)
  end

  def find_resource
    if params.dig(:feedback, :user_id)
      User.find_by(id: params.dig(:feedback, :user_id))
    else
      Post.find_by(id: params.dig(:feedback, :post_id))
    end
  end
end
