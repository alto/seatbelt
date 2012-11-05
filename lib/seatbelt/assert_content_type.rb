module Seatbelt
  module AssertContentType

    SUPPORTED_MIME_TYPES = {
      'html'              => 'text/html',
      'xhtml'             => 'text/html',
      'text'              => 'text/plain',
      'txt'               => 'text/plain',
      'js'                => 'text/javascript',
      'css'               => 'text/css',
      'ics'               => 'text/calendar',
      'csv'               => 'text/csv',
      'xml'               => 'application/xml',
      'rss'               => 'application/rss+xml',
      'atom'              => 'application/atom+xml',
      'yaml'              => 'application/x-yaml',
      'multipart_form'    => 'multipart/form-data',
      'url_encoded_form'  => 'application/x-www-form-urlencoded',
      'json'              => 'application/json',
      'pdf'               => 'application/pdf',
      'xls'               => 'application/vnd.ms-excel'
    }

    def assert_content_type(content_type, header=nil)
      header = @response.headers["Content-Type"] if header.nil? && @response
      if header
        # assert_match /application\/vnd.ms-excel/, @response.header["Content-Type"]
        assert_match matcher_for(content_type), header
      else
        assert false, "nothing to match against!"
      end
    end

  private

  def matcher_for(content_type)
    case content_type
    when Regexp
      content_type
    when String
      Regexp.new((SUPPORTED_MIME_TYPES[content_type] || content_type).gsub('+', '\\\+'))
    else
      raise "type unknown: #{content_type}"
    end
  end

  end
end

if Object.const_defined?(:ActionController)
  class Test::Unit::TestCase
    include Seatbelt::AssertContentType
  end
end
