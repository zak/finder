#!/usr/bin/env ruby

#queries = ['first', 'second', 'third', 'fourth']
queries = %w(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

class WorkerPool
  attr_reader :threads 
  attr_reader :putter

  def initialize(qs)
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

class Putter
  attr_reader :thread

  def initialize(sequence)
    puts "\033[36mstart putter!\033[0m #{sequence}"
    @thread = Thread.new(sequence, 0) do |workers, next_line|
      while next_line < workers.size do
        if workers[next_line] && workers[next_line].thread.stop? && workers[next_line].thread.key?(:result)
          puts "\n\033[32m[putter]\033[0m #{next_line} = #{workers[next_line].thread[:result]}"
          next_line += 1 
        else
          # puts "\n\033[31m[putter]\033[0m wait #{next_line}"
          Thread.pass 
        end
      end
    end
    @thread.priority = 10
  end
end

WorkerPool.new(queries)
