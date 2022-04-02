require './lib/command_parser'

class Executable
    class << self
        def exec(argv)
            CommandParser.parse(argv).result
        end
    end

end