module Finder
  class WorkerPool

    attr_reader :threads 
    attr_reader :putter

    def initialize(qs, args)
      puts "\033[36mstart pool\033[0m"
      @threads = []
      qs.each do |q|
        @threads << Worker.new(q)
      end
      @putter = Putter.new(@threads)
      puts "\033[34m[pool]\033[0m - #{@threads.inspect}"
      wait_workers_and_putter
      puts "\033[34m[pool]\033[0m - #{@threads.inspect}"
    end

    def wait_workers_and_putter
      threads.each do |w|
        w.thread.join
      end
      putter.thread.join
    end

  end
end
