require 'test_helper'

class Seatbelt::AssertContentTypeTest < Test::Unit::TestCase
  include Seatbelt::AssertContentType

  def test_assert_content_type_short
    Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES.each do |short, long|
      @response = stub('Response', :headers => {'Content-Type' => "#{long}; charset=utf-8"})
      assert_content_type short
    end
  end

  def test_assert_content_type_short_crosscheck
    Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES.keys.each do |short|
      @response = stub('Response', :headers => {'Content-Type' => "#{wrong_long_for_short(short)}; charset=utf-8"})
      assert_assertion_fails do
        assert_content_type short
      end
    end
  end

  def test_assert_content_type_long
    Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES.each do |short, long|
      @response = stub('Response', :headers => {'Content-Type' => "#{long}; charset=utf-8"})
      assert_content_type long
    end
  end

  def test_assert_content_type_long_crosscheck
    Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES.each do |short, long|
      @response = stub('Response', :headers => {'Content-Type' => "#{wrong_long_for_short(short)}; charset=utf-8"})
      assert_assertion_fails do
        assert_content_type long
      end
    end
  end

private

  def wrong_long_for_short(short)
    Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES.values.select do |long|
      long != Seatbelt::AssertContentType::SUPPORTED_MIME_TYPES[short]
    end.sort_by { rand }.first
  end

end
