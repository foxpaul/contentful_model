module ContentfulModel
  class Query
    attr_accessor :parameters
    def initialize(referenced_class, parameters=nil)
      @parameters = parameters || {}
      @client = referenced_class.send(:client)
      @referenced_class = referenced_class
    end

    def <<(parameters)
      @parameters.merge!(parameters)
    end

    def default_parameters
      { 'content_type' => @referenced_class.send(:content_type_id) }
    end

    def execute
      query = @parameters.merge!(default_parameters)
      return @client.entries(query)
    end

    def reset
      @parameters = default_parameters
    end
  end
end