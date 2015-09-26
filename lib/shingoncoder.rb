require "shingoncoder/version"
require 'active_support'

module Shingoncoder
  # Your code goes here...
  extend ActiveSupport::Autoload
  autoload :Job
  autoload :Response
  autoload :Backend
end
