module Finder
  class Putter
    attr_reader :thread

    def initialize(sequence)
      @thread = Thread.new(sequence, 0) do |workers, next_line|
        loop do
          break if Thread.main.key?(:stop) && next_line >= Thread.main[:stop]
          if workers[next_line] && workers[next_line].thread.status.nil?
            $stdout.write "#{next_line} \033[31mterminated\033[0m with an exception\n"
            next_line += 1
          end
          if workers[next_line] && workers[next_line].thread.stop? && workers[next_line].thread.key?(:result)
            $stdout.write "#{workers[next_line].thread[:result]}\n"
            next_line += 1
          else
            Thread.pass
          end
        end
      end
      @thread.priority = 10
    end

    def join
      thread.join
    end
  end
end
