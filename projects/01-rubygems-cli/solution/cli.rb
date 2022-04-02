#!/usr/bin/env ruby
require './lib/executable'
require 'pp'


prog = Executable.exec(ARGV)

pp(prog)
