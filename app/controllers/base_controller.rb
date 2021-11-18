# frozen_string_literal: true

# Parent controller
class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def index
    build_response <<~JSON
      {"success":  true, "message": "index from base controller"}
    JSON
  end

  private

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'application/json' }, [body]]
  end

  def error_response(resource)
    JSON.generate({success: false, errors: resource.errors.full_messages})
  end

  def not_found(message = 'Not Found')
    [
      404,
      { 'Content-Type' => 'application/json' },
      [JSON.generate({ success: false, errors: [message] })]
    ]
  end

  def params
    request.params.deep_symbolize_keys
  end
end
