# RedactedAttributes

Stores redacted plain text version of an encrypted value

If you find yourself encrypting a value that you need to sort by, then this gem might help. It stores a redacted version of the string, the first three characters, in another column.

This gem is intended to be used with the symmetric-encryption gem. It assumes that a `redacted_attribute` column exists for the encrypted attribute.

## Example

Let's assume we have the following ActiveRecord model defined.

```ruby
class Widget < ActiveRecord::Base
  attr_encrypted :name
  attr_redacted  :name
end
```

This would require the database schema to look something like this.

```ruby
  create_table "patients", :force => true do |t|
    t.string "encrypted_name"
    t.string "redacted_name"
  end
```

## Installation

Add this line to your application's Gemfile:

    gem 'redacted_attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redacted_attributes

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/corgibytes/redacted_attributes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
