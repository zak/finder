module Finder
  class Putter
    attr_reader :thread

    def initialize(sequence)
      #puts "\033[36mstart putter!\033[0m #{sequence}"
      @thread = Thread.new(sequence, 0) do |workers, next_line|
        while next_line < workers.size do
          #puts "[putter] next_line - #{next_line} #{workers[next_line]}"
          if !workers[next_line].nil? && workers[next_line].thread.stop? && workers[next_line].thread.key?(:result)
            #$stdout.write "\n\033[32m[putter]\033[0m #{next_line} = #{workers[next_line].thread[:result]}"
            $stdout.write "\n#{workers[next_line].thread[:result]}"
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
