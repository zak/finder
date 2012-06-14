require 'spec_helper'

describe Finder::Putter do
  let(:finder_module) { ::Finder }
  let(:putter_module) { finder_module::Putter }

  describe '#initialize' do
    let(:result_string) { 'result string' }
    let(:conclude) do
      th = double('Thread')
      th.stub(:[]).with(:result).and_return(result_string)
      th.stub(:key?).with(:result).and_return(true)
      th.stub(:stop?).and_return(true)
      th.stub(:status).and_return(false)
      w = double('Worker')
      w.stub(:thread).and_return(th)
      w
    end
    let(:unconclude) do
      th = double('Thread')
      th.stub(:[]).with(:result).and_return(result_string)
      th.stub(:key?).with(:result).and_return(false, true)
      th.stub(:stop?).and_return(false, true)
      th.stub(:status).and_return(false)
      w = double('Worker')
      w.stub(:thread).and_return(th)
      w
    end
    let(:exception) do
      th = double('Thread')
      th.stub(:[]).with(:result).and_return(result_string)
      th.stub(:key?).with(:result).and_return(false, true)
      th.stub(:stop?).and_return(false, true)
      th.stub(:status).and_return(nil)
      w = double('Worker')
      w.stub(:thread).and_return(th)
      w
    end
    let(:workers) { [conclude] }
    let(:uncomplete_workers) { [unconclude] }
    let(:exception_workers) { [exception] }

    it "create putter with complite workers" do
      $stdout.should_receive(:write)

      putter = putter_module.new(workers)
      putter.thread.should be_an_instance_of(Thread)
      putter.join
    end

    it "create putter with uncomplite workers" do
      $stdout.should_receive(:write)
      Thread.should_receive(:pass).any_number_of_times

      putter = putter_module.new(uncomplete_workers)
      putter.thread.should be_an_instance_of(Thread)
      putter.join
    end

    it "create putter with exception workers" do
      $stdout.should_receive(:write)

      putter = putter_module.new(exception_workers)
      putter.thread.should be_an_instance_of(Thread)
      putter.join
    end

    it "create putter and set priority and cell join" do
      th = double('Thread')
      th.should_receive(:priority=).with(10)
      th.should_receive(:join)
      Thread.should_receive(:new).and_return(th)

      putter = putter_module.new(exception_workers)
      putter.join
    end
  end
end
