module Shingoncoder
  class Response
    attr_reader :body, :code

    def initialize(properties)
      @code = properties.delete('code')
      @body = properties.fetch('body', properties)
    end


  end
end
