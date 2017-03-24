module Shingoncoder
  class Job
    class << self
      # @param [Hash] options
      # @option [String] :input the url to the file
      # @return [Response]
      def create(options = {})
        id = Backend::Job.create(options)
        # TODO in the future the backend could be via a HTTP API
        Response.new('id' => id, 'code' => 201)
      end

      def cancel
        fail NotImplementedError
      end

      # Each output should have current_event
      # job itself should have 'progress'
      # @return [Response]
      def progress(id)
        job = Shingoncoder::Backend::JobRegistry::Job.find(id)
        Response.new('body' => id, 'code' => 200)
      end

      # should have ["job"]["input_media_file"]["url"]
      # TODO should have ["job"]["state"] which is one of:
      #   "pending", "waiting", "processing", "cancelled", "failed", "finished"
      # TODO include outputs
      # @return [Response]
      def details(id)
        job = Shingoncoder::Backend::JobRegistry::Job.find(id)
        details = { 'job' => { 'id' => id, 'input_media_file' => { 'url' => job.input.fetch('input') }, outputs: [] } }
        details[:outputs] = [] # TODO fill in details here
        Response.new('body' => { 'job' => details }, 'code' => 200)
      end
    end
  end
end
