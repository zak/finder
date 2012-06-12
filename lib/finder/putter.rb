module Finder
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
end
