# frozen_string_literal: true

# Ips controller
class IpsController < BaseController
  def index
    posts = IpListingService.new.call

    build_response JSON.generate({ success: true, data: posts })
  end
end
