module Shingoncoder::Backend
  class TranscodeService
    def initialize(id)
      @id = id
    end

    def transcode
      # Hydra::Derivatives::Video::Processor.encode_file filename
    end
  end
end
