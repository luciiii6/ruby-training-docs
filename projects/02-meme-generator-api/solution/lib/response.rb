class ErrorResponse 
  def initialize(message)
    @data = { 
  'errors' => ['message' => message]
    }
  end

  def to_json
    @data.to_json
  end
end