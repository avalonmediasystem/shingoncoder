module Shingoncoder
  class Job
    class << self
      # @param [Hash] options
      # @option [String] :input the url to the file
      def create(options = {})
        id = Backend::Job.create(options)
        # TODO in the future the backend could be via a HTTP API
        Response.new('id' => id, 'code' => 201)
      end

      def cancel
        fail NotImplementedError
      end

      def progress
        fail NotImplementedError
      end

      def details
        fail NotImplementedError
      end
    end
  end
end
