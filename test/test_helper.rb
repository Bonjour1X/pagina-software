# frozen_string_literal: true
require 'simplecov'
SimpleCov.start do 
  add_group 'models', 'app/models'
  add_group 'controllers', 'app/controllers'
  add_group 'helpers', 'app/helpers'
end
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# Incluye los helpers de Devise para pruebas
require 'devise/test/integration_helpers'

module ActiveSupport
  
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Incluye los helpers de Devise
    include Devise::Test::IntegrationHelpers

    # Add more helper methods to be used by all tests here...
  end
end