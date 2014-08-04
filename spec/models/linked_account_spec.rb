# == Schema Information
#
# Table name: linked_accounts
#
#  id            :integer          not null, primary key
#  uid           :integer
#  person_id     :integer
#  type          :string(255)
#  email         :string(255)
#  image_url     :string(255)
#  oauth_token   :string(255)
#  refresh_token :string(255)
#  expires_at    :string(255)
#  expires_in    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe LinkedAccount do

  context 'with an oauth_object', :requires => :oauth_spec_module do
    before(:each) do
      @auth_obj = AuthHash.new(oauth_hash)
    end

    describe '#find_or_initialize_linked_account' do
      context 'with no linked account' do
        it 'should initialize a new linked account with the correct attributes' do
          linked_account = LinkedAccount.find_or_initialize(@auth_obj)
          expect(linked_account.name).to eq(@auth_obj.name)
        end

        it 'should create a new linked account of the correct type' do
          linked_account = LinkedAccount.find_or_initialize(@auth_obj)
          expect(linked_account.type).to eq('LinkedAccount::Spotify')
        end
      end
    end

    describe '#self.convert_auth_obj_to_attributes' do
      it 'should convert auth_object into attribute hash for instantiation' do
        attribute_hash = LinkedAccount.convert_auth_obj_to_attributes(@auth_obj)
        expect(attribute_hash.keys).to eq([:uid,:type,:name,:email,:image_url,:oauth_token,:refresh_token,:expires_at])
      end
    end
  end

  describe '#self.param_to_type' do
    it 'should convert string param into correct STI type' do
      expect(LinkedAccount.param_to_type('spotify')).to eq('LinkedAccount::Spotify')
    end
  end
end
