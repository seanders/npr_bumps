module AuthHashSpec
  def oauth_hash
  {"provider"=>"spotify",
   "uid"=>"1",
   "info"=>
   {"name"=>"Billy Mays",
     "nickname"=>"billy_mays",
     "email"=>"fake@gmail.com",
     "urls"=>{"spotify"=>"https://open.spotify.com/user/1"},
     "image"=>
     "https://fake_url.jpg"},
     "credentials"=>
     {"token"=>
      "fake_token",
      "refresh_token"=>
      "fake_refresh_token",
      "expires_at"=>1406849118,
      "expires"=>true},
      "extra"=>
      {"raw_info"=>
        {"country"=>"US",
         "display_name"=>"Billy Mays",
         "email"=>"fake@gmail.com",
         "external_urls"=>{"spotify"=>"https://open.spotify.com/user/1"},
         "href"=>"https://api.spotify.com/v1/users/1",
         "id"=>"1",
         "images"=>
         [{"height"=>nil,
          "url"=>
          "http://fake_url.jpg",
          "width"=>nil}],
          "product"=>"premium",
          "type"=>"user",
          "uri"=>"spotify:user:1"}}}
end

end
