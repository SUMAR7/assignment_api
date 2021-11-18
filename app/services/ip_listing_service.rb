# frozen_string_literal: true

class IpListingService
  attr_reader :posts

  def initialize
    @posts = load_data
  end

  def call
    serialize_ips.as_json
  end

  private

  def serialize_ips
    hash = Hash.new([])
    posts.each do |post|
      hash[post.ip_address] = hash[post.ip_address] |= [post.username]
    end
    hash
  end

  def load_data
    Post.joins(:user)
        .select('users.id, users.username, posts.ip_address')
        .group('users.id, posts.ip_address')
  end
end
