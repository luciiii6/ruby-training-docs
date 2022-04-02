require './lib/api_call_cache'
require './lib/show/help_show_command'
require './lib/info_result'

class ShowCommand

  class ShowResult
    attr_reader :name, :info

    def initialize(name, info)
      @name = name
      @info = info
    end
  end

  class << self
    def create(args)
      return HelpShowCommand.new if args.empty? || args.length > 1

      new(args.first)

    end
  end

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def result
    result = ApiCallCache.show(@name)

    if result.success?
      return ShowResult.new(result.data['name'], result.data['info'])
    end

    InfoResult.new(result.data['message'])
  end
end
