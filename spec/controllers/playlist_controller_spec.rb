require 'spec_helper'

describe PlaylistController do

  describe "GET 'sync'" do
    it "returns http success" do
      get 'sync'
      response.should be_success
    end
  end

end
