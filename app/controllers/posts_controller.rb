# frozen_string_literal: true

# Posts controller
class PostsController < BaseController

  MAX_POSTS = 20
  def index
    posts = Post.joins(:ratings)
                .select('posts.id, title, content, avg(ratings.stars) as average_rating')
                .group('posts.id')
                .order('average_rating DESC')
                .limit(params[:max] || MAX_POSTS)

    build_response JSON.generate({ success: true, data: posts.as_json })
  end

  def create
    user = find_or_create_user

    return build_response(error_response(user), status: 422) if user.errors.any?

    post = user.posts.build(post_params)
    if post.save
      build_response JSON.generate(success: true, data: post.as_json)
    else
      build_response error_response(post), status: 422
    end
  end

  def rate
    post = find_post
    return not_found('invalid post id') if post.nil?

    rating = post.ratings.build(rating_params)

    if rating.save
      build_response JSON.generate({ success: true, data: { average_rating: post.average_rating } })
    else
      build_response error_response(rating), status: 422
    end
  end

  private

  def find_post
    Post.find_by(id: params[:id])
  end

  def post_params
    params[:post]&.slice(:title, :content, :ip_address)
  end

  def rating_params
    params[:rating]&.slice(:stars)
  end

  def find_or_create_user
    user = User.find_or_initialize_by(username: params.dig(:post, :username))
    return user if user.persisted?

    user.assign_attributes(ip_address: params.dig(:post, :ip_address))
    user.tap(&:save)
  end
end
