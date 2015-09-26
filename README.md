# Shingoncoder

A asynchronous system for handling video transcoding backed by FFMpeg.

## Installation

Include this gem in your Gemfile

```ruby
gem 'shingoncoder'
```

Create the necessary tables:

```ruby
rails console
Shingoncoder::Backend::JobRegistry::Job.create_table!
```

The asynchronous behavior is handled by ActiveJob, so you need only start your workers in the usual manner.


## Configuration



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcoyne/shingoncoder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

