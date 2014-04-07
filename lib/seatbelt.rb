require "seatbelt/version"
require 'seatbelt/assert_json'
require 'seatbelt/assert_mail'
require 'seatbelt/assert_content_type'

if defined?(Test)
  class Test::Unit::TestCase
    include Seatbelt::AssertContentType if defined?(ActionController)
    include Seatbelt::AssertJson
    include Seatbelt::AssertMail if defined?(ActionMailer)
  end
end

if defined?(Minitest)
  class Minitest::Test
    include Seatbelt::AssertContentType if defined?(ActionController)
    include Seatbelt::AssertJson
    include Seatbelt::AssertMail if defined?(ActionMailer)
  end
end
