module Shingoncoder::Backend
  class Job
    class << self
      # Register the job and kicks off several derivatives.
      # @param [Hash] options
      # @option [String] :input the url to the file
      # @return [Integer] :id for the job
      def create(options)
        uri = URI(options.fetch(:input))
        filename = case uri.scheme
        when 'file'
          uri.path
        else
          raise ArgumentError, "#{uri.scheme} is not yet implemented"
        end

        job = Shingoncoder::Backend::JobRegistry.create(options)

        # TODO decompose into several derivatives
        TranscodeJob.perform_later(job.id)

        # Hydra::Derivatives::Video::Processor.encode_file filename

        job.id
      end
    end
  end
end
