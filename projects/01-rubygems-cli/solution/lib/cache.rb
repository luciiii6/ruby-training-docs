require 'time'

class Cache
  DEFAULT_EXPIRATION_TIME = 24 * 60 * 60
  class << self
    def create
      if File.file?('./cache.json')
        file = File.read('./cache.json')
        Cache.new(JSON.parse(file))
      else
        Cache.new({})
      end
    end
  end

  def initialize(content)
    @content = content
  end

  def write(key, value, expiration_at = Time.now + DEFAULT_EXPIRATION_TIME)
    @content.store(key, {'value' => value, 'expiration_at' => expiration_at})
    refresh
  end

  def read(key)
    entry = @content[key]
    entry['value'] if entry && Time.parse(entry['expiration_at']) > Time.now 
  end
  def refresh
    File.write('./cache.json',JSON.dump(@content))
  end
end