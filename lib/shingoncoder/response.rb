module Shingoncoder
  class Response
    attr_reader :code, :body

    def initialize(properties)
      @id = properties.fetch('id')
      @code = properties.fetch('code')
      @body = { 'id' => @id }
    end
  end
end
