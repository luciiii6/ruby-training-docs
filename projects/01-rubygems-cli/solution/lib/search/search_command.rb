require './lib/api_call'
require './lib/search/help_search_command'
require './lib/info_result'
require './lib/search/search_options_parser'
require './lib/gem_api'

class SearchCommand

  class SearchResult
    attr_reader :gem_list
    def initialize(list)
      @gem_list = list
    end
  end

  class << self
    def create(args)
      return HelpSearchCommand.new if args.empty?
      options = SearchOptionsParser.parse(args) 
      return HelpSearchCommand.new if options.class == StandardError
      args = removeOptions(args)
      new(args.length > 1 ? to_s_query(args) : args[0], options)
    end

    def to_s_query(query)
      string_query = ''
      query.each{ |str| string_query+="+#{str}" }
      string_query[1..]
    end

    def removeOptions(args)
      index = args.find_index { |arg| arg.start_with?('--')}
      return args[0..index - 1] if index
      args
    end

  end

  attr_reader :query, :options
  def initialize(query, options = [])
    @query = query
    @options = options
  end

  def filter(results)
    if @options
      @options.each do |opt|
        results.data = opt.apply(results.data)
      end
    end

    results.data.map { |gem| GemApi.new(gem['name'], gem['info'], gem['version']) }
  end

  def result
    results = ApiCall.search(@query)
    if results.success?
      results.data = filter(results)
      return InfoResult.new('No results found after filtering') unless results.data.length != 0
      return SearchResult.new(results.data)
    end

    InfoResult.new(results.data['message'])
  end
end
