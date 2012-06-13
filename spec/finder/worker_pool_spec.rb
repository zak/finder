require 'spec_helper'

describe Finder::WorkerPool do
  let(:finder_module) { ::Finder }
  let(:pool_module)   { finder_module::WorkerPool }
  let(:worker_module) { finder_module::Worker }
  let(:putter_module) { finder_module::Putter }

  describe '#initialize' do

    it "create worker pool" do
      worker = double('Worker')
      worker.should_receive(:thread).twice.and_return(double('Thread', :join => true))
      putter = double('Putter')
      putter.should_receive(:thread).and_return(double('Thread', :join => true))

      worker_module.should_receive(:new).twice.and_return(worker)
      putter_module.should_receive(:new).once.and_return(putter)
      #pool_module.any_instance.should_receive(:wait_workers_and_putter).once
      pool = pool_module.new(%w(first second), [])
      pool.threads.should have(2).items
    end

    it "wait threads" do

    end

  end
end
