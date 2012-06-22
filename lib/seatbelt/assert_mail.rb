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
      return false if options[:to]      && !mail.to.include?(options[:to])
      return false if options[:from]    && !mail.from.include?(options[:from])
      return false if options[:subject] && (mail.subject !~ /#{options[:subject]}/)
      return false if options[:cc]      && !mail.cc.include?(options[:cc])
      return false if options[:bcc]     && !mail.bcc.include?(options[:bcc])
      if options[:body]
        Array(options[:body]).each do |element|
          if !mail.body.encoded.match(element)
            # puts "#{element} not found in body: #{mail.body.encoded}"
            return false
          end
        end
      end
      true
    end

  end
end
if Object.const_defined?(:ActionMailer)
  class Test::Unit::TestCase
    include Seatbelt::AssertMail
  end
end
