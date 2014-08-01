require 'spec_helper'

describe AuthHash, :requires => :oauth_spec_module do
  let(:init) { AuthHash.new(oauth_hash) }
  describe '#initialize' do
    it 'should assign uid' do
      expect(init.uid).to eq()
    end
  end
end
