require 'spec_helper'

describe Finder::Worker do
  let(:finder_module) { ::Finder }
  let(:worker_module) { finder_module::Worker }

  describe '#initializer' do
    let(:result_string) { 'result string' }
    let(:test_query) { 'test_query' }
    let(:httparty_response) do
      r = {
        'yandexsearch' => {
          'response' => {
            'results' => {
              'grouping' => {
                'group' =>
                  [0, {"doc" => {"domain" => result_string }}]
              }
            }
          }
        }
      }
      r.stub(:code).and_return(200)
      r
    end

    it "creat thread and get value" do
      HTTParty.should_receive(:get).once.and_return(httparty_response)

      worker = worker_module.new(test_query)
      worker.thread.should be_an_instance_of(Thread)
      worker.thread.join
      worker.thread[:result].should eq(result_string)
    end

    it "get bad request" do
      HTTParty.should_receive(:get).once.and_return(double('HTTPParty', :code => 500))

      worker = worker_module.new(test_query)
      worker.thread.join
      worker.thread[:result].should eq("[Error] for #{test_query} code - 500")
    end

    it "creat thread and get value" do
      HTTParty.should_receive(:get).once.and_return(httparty_response)

      worker = worker_module.new(test_query, 3)
      worker.thread.join
      worker.thread[:result].should eq("[Parsing error] for query - #{test_query}")
    end
  end
end
