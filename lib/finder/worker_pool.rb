module Finder
  class WorkerPool

    attr_reader :threads
    attr_reader :putter

    def initialize(qs, args)
      number_row = args.map do |arg|
        $1 if arg.match(/-n(\d)/)
      end.compact.first

      @threads = []
      qs.each do |q|
        @threads << Worker.new(q, number_row)
      end
      @putter = Putter.new(@threads)
      wait_putter
    end

    def wait_putter
      putter.join
    end

  end
end
