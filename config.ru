# frozen_string_literal: true

require './app/application'

use Rack::Reloader, 0
run Application.new
