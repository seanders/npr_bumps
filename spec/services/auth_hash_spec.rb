require 'spec_helper'

describe AuthHash, :requires => :oauth_spec_module do
  # let(:init) { AuthHash.new(oauth_hash) }

  describe '#initialize' do
    before(:all) do
      @auth_hash = AuthHash.new(oauth_hash)
    end

    it 'should assign uid' do
      expect(@auth_hash.uid).to eq("1")
    end

    it 'should assign type' do
      expect(@auth_hash.type).to eq("spotify")
    end

    it 'should assign the name' do
      expect(@auth_hash.name).to eq("Billy Mays")
    end

    it 'should assign the email' do
      expect(@auth_hash.email).to eq("fake@gmail.com")
    end

    it 'should assign the image_url' do
      expect(@auth_hash.image_url).to eq("https://fake_url.jpg")
    end

    it 'should assign the oauth_token' do
      expect(@auth_hash.token).to eq("fake_token")
    end

    it 'should assign the refresh token' do
      expect(@auth_hash.refresh_token).to eq("fake_refresh_token")
    end

    it 'should assign expires_at' do
      expect(@auth_hash.expires_at).to eq(1406849118)
    end
  end
end
