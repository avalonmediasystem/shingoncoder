module Shingoncoder
  class Response
    attr_reader :body, :code

    def initialize(opts)
      properties = opts.with_indifferent_access
      @code = properties.delete(:code)
      @body = properties.fetch(:body, properties)
    end

    def success?
      true
    end
  end
end
