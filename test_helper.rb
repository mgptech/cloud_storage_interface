require "minitest/autorun"
require 'cloud_storage_interface'
require 'active_support/all'
require 'mocha/mini_test'
require 'byebug'


module ActiveSupport
  def self.test_order
    :random
  end
end