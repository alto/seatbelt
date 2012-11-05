require 'multi_json'
module Seatbelt
  module AssertJson

    def assert_json(json_string, &block)
      if block_given?
        @json = AssertJson::Json.new(json_string)
        # json.instance_exec(json, &block)
        yield @json
      end
    end

    def has(*args, &block)
      @json.has(*args, &block)
    end

    def has_not(*args, &block)
      @json.has_not(*args, &block)
    end

    class Json

      def initialize(json_string)
        @decoded_json = MultiJson.decode(json_string)
      end

      def has(*args, &block)
        arg = args.shift
        token = @decoded_json.is_a?(Array) ? @decoded_json.shift : @decoded_json

        case token
        when Hash
          has_hash(token, arg, args)
        when Array
          has_array(token, arg)
        when String
          has_string(token, arg)
        when NilClass
          raise_error("no element left")
        else
          flunk
        end

        if block_given?
          begin
            in_scope, @decoded_json = @decoded_json, token.is_a?(Hash) ? token[arg] : token
            yield
          ensure
            @decoded_json = in_scope
          end
        end

      end
      alias element has

      def has_not(*args, &block)
        arg = args.shift
        token = @decoded_json
        case token
        when Array
          raise_error("element #{arg} found, but not expected") if token.include?(arg)
        else
          raise_error("element #{arg} found, but not expected") if token.keys.include?(arg)
        end
      end
      alias not_element has_not

    private

      def raise_error(message)
        if Object.const_defined?(:MiniTest)
          raise MiniTest::Assertion.new(message)
        else
          raise Test::Unit::AssertionFailedError.new(message)
        end
      end

      def has_hash(token, arg, args)
        raise_error("element #{arg} not found") unless token.keys.include?(arg)
        if second_arg = args.shift
          case second_arg
          when Regexp
            raise_error("element #{token[arg].inspect} does not match #{second_arg.inspect}") if second_arg !~ token[arg]
          else
            raise_error("element #{token[arg].inspect} does not match #{second_arg.inspect}") if second_arg != token[arg]
          end
        end
      end

      def has_array(token, arg)
        raise_error("element #{arg} not found") if token != arg
      end

      def has_string(token, arg)
        case arg
        when Regexp
          raise_error("element #{arg.inspect} not found") if token !~ arg
        else
          raise_error("element #{arg.inspect} not found") if token != arg
        end
      end

    end
  end
end

class Test::Unit::TestCase
  include Seatbelt::AssertJson
end
