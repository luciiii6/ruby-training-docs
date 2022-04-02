require 'optparse'
require './lib/search/search_option_downloads'
require './lib/search/search_option_license'

class SearchOptionsParser
  class << self
    def parse(args)
      begin
        options = []
        optparse = OptionParser.new do |opts|
          opts.on('--license LICENSE', 'Show the gem information') do |license|
              options.append(SearchOptionLicense.new(license))
          end
          opts.on('--most-downloads-first', 'Show gems found by entered text') do
              options.append(SearchOptionDownloads.new)
          end
        end
        optparse.parse(args)
        return options
      rescue StandardError => e
        options = StandardError.new
      end
      
    end   
  end
end
