require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tangerine::Base do

  context 'class methods' do
    subject { Tangerine::Base }

    describe '.find' do
      before do
        items = []
        5.times { items << mock_item }
        @target_item = {'embedCode' => embed_code}
        items << @target_item

        klass = Class.new(Tangerine::Base) do
          attr_accessor :embed_code
          finder do
            items
          end
        end
        TestBaseClass = klass
      end

      let(:embed_code) { 'target_embed_code' }
      let(:mock_item) { {'embedCode' => Factory.next(:embed_code)} }

      it 'returns the object associated with the given embed code' do
        result = TestBaseClass.find(embed_code)
        result.class.should == TestBaseClass
        result.embed_code.should == embed_code
      end
    end

    describe '.prepare_items' do

      context 'when given an array' do
        let(:items) { %w(lorem ipsum dolor) }

        it 'makes no changes, and just returns the items' do
          subject.prepare_items(items).should == items
        end
      end

      context 'when given a hash' do
        let(:items) { {:lorem => 'ipsum'} }

        it 'wraps the given hash in an array' do
          subject.prepare_items(items).should == [items]
        end
      end

    end
  end

end
