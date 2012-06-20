#!/usr/bin/env ruby

#queries = ['first', 'second', 'third', 'fourth']
queries = %w(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

class WorkerPool
  attr_reader :threads 
  attr_reader :putter

  def initialize(qs)
    $stdout.write "\033[36mstart pool\033[0m\n"
    @threads = []
    @putter = Putter.new(@threads)
    qs.each do |q|
      loop do
        sth = @threads.inject(0) {|s,t| s += 1 if t.thread.alive?; s }
        #$stdout.write "[init th] stop - #{sth}\n"
        if sth < 5
          @threads << Worker.new(q)
          break
        end
        #Thread.pass
      end
    end
    Thread.main[:stop] = @threads.size
    $stdout.write "\033[34m[pool]\033[0m - #{@threads.size}\n"
    wait_putter
    $stdout.write "\033[34m[pool]\033[0m - #{@threads.size}\n"
  end

  def wait_putter
    putter.thread.join
  end
end

class Worker
  attr_reader :thread

  def initialize(q)
    @thread = Thread.new(q) do |query|
      $stdout.write "\033[35m[worker]\033[0m start for #{query}\n"
      sleep(rand(10))
      $stdout.write "\033[31m[worker]\033[0m add result for #{query}\n"
      Thread.current[:result] = "result for #{query}"
    end
  end
end

class Putter
  attr_reader :thread

  def initialize(sequence)
    $stdout.write "\033[36mstart putter!\033[0m"
    @thread = Thread.new(sequence, 0) do |workers, next_line|
      #while next_line < workers.size do
      loop do
        break if Thread.main.key?(:stop) && next_line >= Thread.main[:stop]
        if workers[next_line] && workers[next_line].thread.stop? && workers[next_line].thread.key?(:result)
          $stdout.write "\033[32m[putter]\033[0m #{next_line} = #{workers[next_line].thread[:result]}\n"
          next_line += 1 
        else
          # $stdout.write "\n\033[31m[putter]\033[0m wait #{next_line}"
          Thread.pass 
        end
      end
    end
    @thread.priority = 10
  end
end

WorkerPool.new(queries)
