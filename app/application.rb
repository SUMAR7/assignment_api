# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'development'

require 'pg'
require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'
require 'json'
require './app/models/user'
require './app/models/post'
require './app/models/feedback'
require './app/models/rating'
require './app/runner'
require './app/router'
require './app/controllers/base_controller'
require './app/controllers/posts_controller'
require './app/controllers/ips_controller'
require './app/controllers/feedbacks_controller'
require './app/services/ip_listing_service'

Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')

def db_configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result

  YAML.safe_load(db_configuration_result, aliases: true)
end

ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])

app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require(file) }

# Application Class
class Application
  def call(env)
    request = Rack::Request.new(env)
    serve_request(request)
  end

  def serve_request(request)
    Router.new(request).route!
  end
end
