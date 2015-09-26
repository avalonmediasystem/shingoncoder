module Shingoncoder
  module Backend
    extend ActiveSupport::Autoload
    autoload :Job
    autoload :JobRegistry
    autoload :TranscodeJob
    autoload :TranscodeService
  end
end
