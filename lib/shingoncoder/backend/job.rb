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

        job.outputs.each do |output|
          TranscodeJob.perform_later(output.id)
        end

        job.id
      end
    end
  end
end
