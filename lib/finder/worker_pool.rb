module Finder
  class WorkerPool

    attr_reader :threads
    attr_reader :putter

    def initialize(argv)
      number_row = argv.map do |arg|
        $1 if arg.match(/-n(\d)/)
      end.compact.first

      @threads = []
      @putter = Putter.new(@threads)
      $stdin.each_line do |q|
        loop do
          if @threads.inject(0) {|alive, worker| alive += 1 if worker.thread.alive?; alive} < 5
            @threads << Worker.new(q, number_row)
            break
          end
        end
      end
      Thread.main[:stop] = @threads.size
      wait_putter
    end

    def wait_putter
      putter.join
    end

  end
end
