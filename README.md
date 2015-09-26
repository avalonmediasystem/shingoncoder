# Shingon

A asynchronous system for handling video transcoding backed by FFMpeg.

## Installation

Include this gem in your Gemfile

```ruby
gem 'shingon'
```

Run the migration generator:

```ruby
rails generate active_record:shingon_migration
```

The asynchronous behavior is handled by ActiveJob, so you need only start your workers in the usual manner.


## Configuration



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcoyne/shingon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

