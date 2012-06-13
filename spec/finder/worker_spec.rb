require 'spec_helper'

describe Finder::Worker do
  let(:finder_module) { ::Finder }
  let(:worker_module) { finder_module::Worker }

  describe ':initializer' do
    it "creat thread and get value" do
      #Finder::Worker.any_instance.should_recieve(:get).with(any_args()).and_return('result string')
      worker_module.any_instance.should_receive(:get).with(any_args()).and_return('result string')
      #Finder::Worker.stub!(:new).and_return do |*args|
      #  w = Finder::Worker.proxied_by_rspec__new(*args)
      #  w.should_recieve(:get).with(any_args()).and_return('result string')
      #  w
      #end

      #Finder::Worker.stub(:get).and_return('result string')

      worker = worker_module.new('test query')
      worker.thread.should be_an_instance_of(Thread)
      worker.thread.join
      worker.thread[:result].should eq('result string') 
    end
  end
end
