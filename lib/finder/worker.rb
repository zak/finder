module Finder
  class Worker
    attr_reader :thread

    def initialize(q)
      @thread = Thread.new(q) do |query|
        puts "\n\033[35m[worker]\033[0m start for #{query}"
        sleep(rand(10))
        puts "\n\033[31m[worker]\033[0m add result for #{query}"
        Thread.current[:result] = "result for #{query}"
      end
    end
  end
end
