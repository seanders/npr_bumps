require 'spec_helper'

describe LinkedAccount::Spotify do
  let(:spotify_account_with_fresh_token) {create(:spotify_account)}
  let(:spotify_account_with_expired_token) {create(:spotify_account_with_expired_token)}

  describe '#oauth_token_fresh?' do
    context 'with a fresh token' do
      it 'should return true if the oauth token has not expired' do
        expect(spotify_account_with_fresh_token.oauth_token_fresh?).to be_true
      end
    end

    context 'with an expired token' do
      it 'should return false if the oauth token has expired' do
        expect(spotify_account_with_expired_token.oauth_token_fresh?).to be_false
      end
    end
  end

  describe '#valid_oauth_token' do
    let(:stubbed_spotify_response) do
      {'access_token' => 'dat new token', 'expires_in' => DateTime.now.to_i }
    end

    it 'should the current oauth_token if is fresh' do
      expect(spotify_account_with_fresh_token.valid_oauth_token).to eq (spotify_account_with_fresh_token.oauth_token)
    end

    it 'should return a new ouath token if the previous one expired' do
      # stub dat shit
      spotify_account_with_expired_token.stub(:request_new_oauth_token) { stubbed_spotify_response }
      # test dat shit
      expect(spotify_account_with_expired_token.valid_oauth_token).to eq(stubbed_spotify_response['access_token'])
    end
  end
end

# Sample refresh response from Spotify
# {"access_token"=>
#   "SDFS-f3_25suksn_K-Gye2FtncBu4q8bqtL4SaFDeEOj657pvrYsysfJdXfzx67saG_xe_RGXNv600ClC-KAc0-VGhAR3FdzjeXQigoEJcrdNpFCQl8yHXv7geFG2N5iV4Tl43ye0bq5jzA_89cLxLBRRCWi9BDsfSnshynjIbqiB7mUo4nUNPX-9-1mQXE0p_-J6A",
#  "token_type"=>"Bearer",
#  "expires_in"=>3600}
