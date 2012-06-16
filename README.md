# Seatbelt

Provide a number of custom assertions for Ruby and Ruby on Rails

## Installation

Add this line to your application's Gemfile:

    gem 'seatbelt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install seatbelt

## Usage

### assert_json

Test your [JSON](http://www.json.org/) strings

```ruby
class MyActionTest < ActionController::TestCase
  include Seatbelt::AssertJson

  def test_my_action
    get :my_action, :format => 'json'
    # => @response.body= '{"key":[{"inner_key1":"value1"},{"inner_key2":"value2"}]}'

    assert_json @response.body do
      has 'key' do
        has 'inner_key1', 'value1'
        has 'inner_key2', /lue2/
      end
      has_not 'key_not_included'
    end
  end

end
```

### assert_mail

Test your Rails [ActionMailer](http://guides.rubyonrails.org/action_mailer_basics.html) deliveries.

```ruby
class MyTest < Test::Unit::TestCase

  def test_mail
    this_sends_an_email
    assert_mail :to => 'recipient@email.com', :subject => 'the subject'
  end

  def test_with_block
    assert_mail :to => 'recipient@email.com', :subject => 'the subject' do
      assert_mail :to => 'another@email.com', :subject => 'used as regular expression'
        this_sends_two_emails
      end
    end
  end

  def test_the_mail_body
    assert_mail :to => 'recipient@email.com', :body => ['part 1', 'part 2'] do
      this_sends_an_email
    end
  end

  def test_the_full_mail
    assert_mail :from     => 'sender@email.com',
                :to       => 'recipient@email.com',
                :cc       => 'cc@email.com',
                :bcc      => 'bcc@email.com',
                :subject  => 'subject',
                :body     => ['part 1', 'part 2'] do
      this_sends_an_email
    end
  end

  def test_crosscheck
    assert_no_mail do
      this_should_not_send_an_email
    end
  end

  def test_other_crosscheck
    assert_no_mail :to => 'dontwantemails@email.com' do
      this_should_not_send_an_email
    end
  end

end
```


## Changelog ##

Look at the [CHANGELOG](https://github.com/xing/assert_json/blob/master/CHANGELOG.md) for details.

## Authors ##

  * [Thorsten Böttger](http://github.com/alto)

## How to contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
