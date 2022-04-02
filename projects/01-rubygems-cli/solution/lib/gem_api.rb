class GemApi
  attr_reader :name, :info, :version
  def initialize(name, info, version)
    @name = name
    @info = info
    @version = version
  end

end