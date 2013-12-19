require 'spec_helper'

describe KBBMotorcycle do
  describe 'price' do
    context 'with no information provided' do
      before :each do
        @sut = KBBMotorcycle.new
      end

      it 'should return nil' do
        expect(@sut.price).to be_nil
      end
    end
  end
end
