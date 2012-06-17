module Finder
  class WorkerPool

    attr_reader :threads
    attr_reader :putter

    def initialize
      number_row = ARGV.map do |arg|
        $1 if arg.match(/-n(\d)/)
      end.compact.first

      @threads = []
      @putter = Putter.new(@threads)
      $stdin.each_line do |q|
        @threads << Worker.new(q, number_row)
      end
      Thread.main[:stop] = @threads.size
      wait_putter
    end

    def wait_putter
      putter.join
    end

  end
end
