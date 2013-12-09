module Seatbelt
  module AssertMail

    def assert_mail(options={}, &block)
      assert !find_email(options, &block).nil?, "couldn't find the expected mail (#{options.inspect}) in #{ActionMailer::Base.deliveries.inspect}"
    end

    def assert_no_mail(options={}, &block)
      assert find_email(options, &block).nil?, "didn't expect mail (#{options.inspect}) in #{ActionMailer::Base.deliveries.inspect}"
    end

  private

    def find_email(options, &block)
      if block_given?
        ActionMailer::Base.deliveries.clear
        yield
      end
      ActionMailer::Base.deliveries.detect do |mail|
        got_mail?(mail, options)
      end
    end

    def got_mail?(mail, options={})
      return false if unexpected_recipient?(mail, options)
      return false if unexpected_sender?(mail, options)
      return false if unexpected_subject?(mail, options)
      return false if unexpected_copy?(mail, options)
      return false if unexpected_blind_copy?(mail, options)
      return false if unexpected_body?(mail, options)
      true
    end

    def unexpected_recipient?(mail, options)
      options[:to] && !mail.to.include?(options[:to])
    end

    def unexpected_sender?(mail, options)
      options[:from] && !mail.from.include?(options[:from])
    end

    def unexpected_subject?(mail, options)
      case options[:subject]
      when String
        mail.subject != options[:subject]
      when Regexp
        mail.subject !~ /#{options[:subject]}/
      else
        false
      end
    end

    def unexpected_copy?(mail, options)
      options[:cc] && !mail.cc.include?(options[:cc])
    end

    def unexpected_blind_copy?(mail, options)
      options[:bcc] && !mail.bcc.include?(options[:bcc])
    end

    def unexpected_body?(mail, options)
      if options[:body]
        Array(options[:body]).each do |element|
          if !mail.body.encoded.match(element)
            # puts "#{element} not found in body: #{mail.body.encoded}"
            return true
          end
        end
      end
      false
    end

  end
end
if Object.const_defined?(:ActionMailer)
  class Test::Unit::TestCase
    include Seatbelt::AssertMail
  end
end
if Object.const_defined?(:ActiveSupport)
  class ActiveSupport::TestCase
    include Seatbelt::AssertMail
  end
end
