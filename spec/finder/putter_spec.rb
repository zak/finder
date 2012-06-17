require 'spec_helper'

describe Finder::Putter do
  let(:finder_module) { ::Finder }
  let(:putter_module) { finder_module::Putter }

  describe '#initialize' do
    let(:result_string) { 'result string' }

    let(:thread) do
      th = double('Thread')
      th.stub(:[]).with(:result).and_return(result_string)
      th.stub(:key?).with(:result).and_return(false, true)
      th.stub(:stop?).and_return(false, true)
      th.stub(:status).and_return(false)
      th
    end
    let(:workers) do
      w = double('Worker')
      w.stub(:thread).and_return(thread)
      [w]
    end
    let(:exception_workers) do
      thread.stub(:status).and_return(nil)
      workers
    end

    before do
      Thread.stub(:main).and_return(double(:key? => true, :[] => 1))
    end

    it "create putter with uncomplite and complite workers" do
      $stdout.should_receive(:write).with("#{result_string}\n")
      Thread.should_receive(:pass).twice

      putter = putter_module.new(workers)
      putter.thread.should be_an_instance_of(Thread)
      putter.join
    end

    it "create putter with exception workers" do
      $stdout.should_receive(:write).with("0 \e[31mterminated\e[0m with an exception\n")

      putter = putter_module.new(exception_workers)
      putter.thread.should be_an_instance_of(Thread)
      putter.join
    end

    it "create putter and set priority and call join" do
      th = double('Thread')
      th.should_receive(:priority=).with(10)
      th.should_receive(:join)
      Thread.should_receive(:new).and_return(th)

      putter = putter_module.new(exception_workers)
      putter.join
    end
  end
end
