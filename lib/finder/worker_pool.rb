module Finder
  class WorkerPool

    attr_reader :threads
    attr_reader :putter

    def initialize(qs, args)
      @threads = []
      qs.each do |q|
        @threads << Worker.new(q)
      end
      @putter = Putter.new(@threads)
      wait_putter
    end

    def wait_putter
      putter.join
    end

  end
end
