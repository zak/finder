require 'spec_helper'

describe Finder::Worker do
  let(:finder_module) { ::Finder }
  let(:worker_module) { finder_module::Worker }

  describe ':initializer' do
    let(:result_string) { 'result string' }
    let(:test_query) { 'test_query' }

    it "creat thread and get value" do
      worker_module.any_instance.should_receive(:get).with(any_args()).and_return(result_string)

      worker = worker_module.new(test_query)
      worker.thread.should be_an_instance_of(Thread)
      worker.thread.join
      worker.thread[:result].should eq(result_string)
    end
  end
end
