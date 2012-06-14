require 'httparty'

module Finder
  class Worker
    attr_reader :thread
    attr_reader :response

    def initialize(query, number_row=1)
      @thread = Thread.new(query, number_row) do |query, number_row|
        Thread.current[:result] = get(query, number_row)
      end
    end

    def get(query, number_row)
      response = HTTParty.get(request(URI.escape(query)))
      return "[Error] for #{query} code - #{response.code}" if response.code != 200
      response['yandexsearch']['response']['results']['grouping']['group'][number_row.to_i - 1]["doc"]["domain"] rescue "[Parsing error] for query - #{query}"
    end

    def request(query)
      "http://xmlsearch.yandex.ru/xmlsearch?user=zak2k&key=03.26085125:dbd5240d28107639804e5f74340693ea&query=#{query}"
    end
  end
end
