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
Shingoncoder::Backend::JobRegistry.create_tables!
```

The asynchronous behavior is handled by ActiveJob, so you need only start your workers in the usual manner.


## Configuration

TODO

## Usage

```ruby
Shingoncoder::Job.create(input: 'file:///opt/originals/full.mov')
Shingoncoder::Job.create(input: 'file:///opt/originals/full.mov',
                         outputs: [{ label: 'vp8 for the web',
                                     url: 'file:///opt/derivatives/output.webm'}])
```

This returns a Shingoncoder::Response object which contains a Job ID and one or more Output IDs (one per output file).

### Output options
```
url - where to put the file, (Must be a file URI for now)
size - The resolution of the output video (WxH, in pixels).
label - optional label
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jcoyne/shingoncoder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

