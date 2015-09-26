module Shingoncoder
  module Backend
    extend ActiveSupport::Autoload
    autoload :Job
    autoload :JobRegistry
    autoload :TranscodeJob
    autoload :TranscodeService
    autoload :Config
  end
end
