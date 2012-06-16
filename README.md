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

Test your [JSON](http://www.json.org/) strings

```ruby
class MyActionTest < ActionController::TestCase
  include AssertJson

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
