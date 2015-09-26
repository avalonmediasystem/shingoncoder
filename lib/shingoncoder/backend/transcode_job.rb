require 'active_job'
module Shingoncoder::Backend
  class TranscodeJob < ActiveJob::Base
    queue_as :shingoncoder

    # @param [Fixnum] id the identifier of the job registry record
    def perform(id)
      TranscodeService.new(id).transcode
    end
  end
end
