module Shingoncoder
  module Backend
    class Job
      class << self
        # Register the job and kicks off several derivatives.
        # @param [Hash] options
        # @option [String] :input the url to the file
        # @return [Integer] :id for the job
        def create(input)
          uri = URI(input.fetch(:input))
          filename = case uri.scheme
          when 'file'
            uri.path
          else
            raise ArgumentError, "#{uri.scheme} is not yet implemented"
          end

          id = Shingoncoder::Backend::JobRegistry.create

          # TODO decompose into several derivatives
          FfmpegJob.perform_later(filename)

          # Hydra::Derivatives::Video::Processor.encode_file filename

          id
        end
      end
    end
  end
end
