require 'maxitest/autorun'
require 'active_support'
require 'action_mailer'
require 'json'
require 'mocha/minitest'

$:.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/seatbelt.rb'

# Requiring custom spec helpers
Dir[File.dirname(__FILE__) + "/helpers/**/*.rb"].sort.each { |f| require File.expand_path(f) }


# Turn.config.format = :dot

class Minitest::Test
  def assert_assertion_fails(&block)
    assert_raises(::Minitest::Assertion, &block)
  end
end
