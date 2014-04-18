require 'minitest/autorun'
# require 'turn/autorun'
require 'active_support'
require 'action_mailer'
require 'json'
require 'mocha/setup'

$:.push File.expand_path("../../lib", __FILE__)
require File.dirname(__FILE__) + '/../lib/seatbelt.rb'

# Requiring custom spec helpers
Dir[File.dirname(__FILE__) + "/helpers/**/*.rb"].sort.each { |f| require File.expand_path(f) }


# Turn.config.format = :dot

class Minitest::Unit::TestCase
  def assert_assertion_fails(&block)
    if Object.const_defined?(:MiniTest)
      assert_raises(MiniTest::Assertion, &block)
    else
      assert_raises(Test::Unit::AssertionFailedError, &block)
    end
  end
end
