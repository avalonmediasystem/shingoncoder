require "shingoncoder/version"
require 'active_support'
require 'active_record'

module Shingoncoder
  extend ActiveSupport::Autoload
  autoload :Job
  autoload :Response
  autoload :Backend
end
