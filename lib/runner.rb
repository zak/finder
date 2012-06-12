#!/usr/bin/env ruby
require 'finder'
Finder::WorkerPool.new($stdin.read.split("\n"), ARGV)
