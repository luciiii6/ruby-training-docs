require 'faraday'
require './lib/show/show_command'
require './results/success'
require './results/failure'
require './lib/gem_api'
require './lib/cache'
require './lib/api_call'
require 'digest'

class ApiCallCache
  class << self   
    def show(name)  
      cache = Cache.create
      key = keygen("show #{name}")
      data = cache.read(key)
      if data
        puts "Returning from cache"
        Success.new(data)
      else
        result = ApiCall.show(name)
        cache.write(key,result.data)
        result
      end
    end

    def search(query)     
      cache = Cache.create
      key = keygen("search #{query}")
      data = cache.read(key)
      if data
        puts "Returning from cache"
        Success.new(data)
      else
        result = ApiCall.search(query)
        cache.write(key,result.data)
        result
      end
    end

    def keygen(url)
      Digest::MD5.hexdigest(url)
    end
  end
end