require 'spec_helper'

describe Finder::WorkerPool do
  let(:finder_module) { ::Finder }
  let(:pool_module)   { finder_module::WorkerPool }
  let(:worker_module) { finder_module::Worker }
  let(:putter_module) { finder_module::Putter }

  describe '#initialize' do
    let(:putter) { double('Putter') }
    let(:stub_putter) { putter.stub(:join); putter }
    before do
      STDIN.stub(:each_line).and_yield('first').and_yield('second')
    end

    it "create worker pool" do
      putter.should_receive(:join)
      putter_module.should_receive(:new).once.and_return(putter)
      main = double('Thread')
      main.should_receive(:[]=).with(:stop, 2)
      Thread.should_receive(:main).and_return(main)

      pool = pool_module.new([])
      pool.threads.should have(2).items
    end

    it "create worker pool with arg" do
      putter_module.should_receive(:new).with(any_args(), '3').once.and_return(stub_putter)

      pool = pool_module.new(['-n3'])
    end

  end
end
