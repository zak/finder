require 'spec_helper'

describe Finder::WorkerPool do
  let(:finder_module) { ::Finder }
  let(:pool_module)   { finder_module::WorkerPool }
  let(:worker_module) { finder_module::Worker }
  let(:putter_module) { finder_module::Putter }

  describe '#initialize' do

    it "create worker pool" do
      putter = double('Putter')
      putter.should_receive(:join)

      putter_module.should_receive(:new).once.and_return(putter)
      pool = pool_module.new(%w(first second), [])
      pool.threads.should have(2).items
    end

    it "create worker pool with arg" do
      putter = double('Putter')
      putter.should_receive(:join)

      putter_module.should_receive(:new).with(any_args(), '3').once.and_return(putter)
      pool = pool_module.new(%w(first second), ['garbage', '-n3'])
      pool.threads.should have(2).items
    end

  end
end
