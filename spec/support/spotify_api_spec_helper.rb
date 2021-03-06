module SpotifyApiSpecHelper
  def mock_search_response
    {"tracks"=>
      {"href"=>
        "https://api.spotify.com/v1/search?query=album%3A%27Disgraceland%27+artist%3A%27The+Orwells%27+track%3A%27Southern+Comfort%27&offset=0&limit=20&type=track",
       "items"=>
        [{"album"=>
           {"album_type"=>"album",
            "available_markets"=>
             ["AD",
              "AR",
              "AT",
              "BE",
              "BG",
              "BO",
              "BR",
              "CH",
              "CL",
              "CO",
              "CR",
              "CY",
              "CZ",
              "DE",
              "DK",
              "DO",
              "EC",
              "EE",
              "ES",
              "FI",
              "FR",
              "GB",
              "GR",
              "GT",
              "HK",
              "HN",
              "HU",
              "IE",
              "IS",
              "IT",
              "LT",
              "LU",
              "LV",
              "MC",
              "MT",
              "MX",
              "MY",
              "NI",
              "NL",
              "NO",
              "NZ",
              "PA",
              "PE",
              "PH",
              "PL",
              "PT",
              "PY",
              "RO",
              "SE",
              "SG",
              "SI",
              "SK",
              "SV",
              "TR",
              "TW",
              "UY"],
            "external_urls"=>
             {"spotify"=>"https://open.spotify.com/album/3BOHyC1reu2olTMX66oQ5b"},
            "href"=>"https://api.spotify.com/v1/albums/3BOHyC1reu2olTMX66oQ5b",
            "id"=>"3BOHyC1reu2olTMX66oQ5b",
            "images"=>
             [{"height"=>640,
               "url"=>
                "https://i.scdn.co/image/ba99f5991cf43ce45169334517d7f0e09faa46f0",
               "width"=>640},
              {"height"=>300,
               "url"=>
                "https://i.scdn.co/image/1fda84053f7a90280cfe4823a47493f10c8e494d",
               "width"=>300},
              {"height"=>64,
               "url"=>
                "https://i.scdn.co/image/266bc7ab39128b0c0bde310ae0ff0f3e2f166a0c",
               "width"=>64}],
            "name"=>"Disgraceland",
            "type"=>"album",
            "uri"=>"spotify:album:3BOHyC1reu2olTMX66oQ5b"},
          "artists"=>
           [{"external_urls"=>
              {"spotify"=>
                "https://open.spotify.com/artist/7ia4FaCVsbXvhVwagCJk7l"},
             "href"=>"https://api.spotify.com/v1/artists/7ia4FaCVsbXvhVwagCJk7l",
             "id"=>"7ia4FaCVsbXvhVwagCJk7l",
             "name"=>"The Orwells",
             "type"=>"artist",
             "uri"=>"spotify:artist:7ia4FaCVsbXvhVwagCJk7l"}],
          "available_markets"=>
           ["AD",
            "AR",
            "AT",
            "BE",
            "BG",
            "BO",
            "BR",
            "CH",
            "CL",
            "CO",
            "CR",
            "CY",
            "CZ",
            "DE",
            "DK",
            "DO",
            "EC",
            "EE",
            "ES",
            "FI",
            "FR",
            "GB",
            "GR",
            "GT",
            "HK",
            "HN",
            "HU",
            "IE",
            "IS",
            "IT",
            "LT",
            "LU",
            "LV",
            "MC",
            "MT",
            "MX",
            "MY",
            "NI",
            "NL",
            "NO",
            "NZ",
            "PA",
            "PE",
            "PH",
            "PL",
            "PT",
            "PY",
            "RO",
            "SE",
            "SG",
            "SI",
            "SK",
            "SV",
            "TR",
            "TW",
            "UY"],
          "disc_number"=>1,
          "duration_ms"=>164000,
          "explicit"=>false,
          "external_ids"=>{"isrc"=>"USAT21401105"},
          "external_urls"=>
           {"spotify"=>"https://open.spotify.com/track/7r87p4bnlP642xfobiCZlj"},
          "href"=>"https://api.spotify.com/v1/tracks/7r87p4bnlP642xfobiCZlj",
          "id"=>"7r87p4bnlP642xfobiCZlj",
          "name"=>"Southern Comfort",
          "popularity"=>46,
          "preview_url"=>
           "https://p.scdn.co/mp3-preview/115d3cc0393302a6baf99b73fda5e507bf2317e7",
          "track_number"=>1,
          "type"=>"track",
          "uri"=>"spotify:track:7r87p4bnlP642xfobiCZlj"},
         {"album"=>
           {"album_type"=>"album",
            "available_markets"=>["AU", "CA", "US"],
            "external_urls"=>
             {"spotify"=>"https://open.spotify.com/album/1fQBO5rMjjml5ynOiiqPi3"},
            "href"=>"https://api.spotify.com/v1/albums/1fQBO5rMjjml5ynOiiqPi3",
            "id"=>"1fQBO5rMjjml5ynOiiqPi3",
            "images"=>
             [{"height"=>640,
               "url"=>
                "https://i.scdn.co/image/ba99f5991cf43ce45169334517d7f0e09faa46f0",
               "width"=>640},
              {"height"=>300,
               "url"=>
                "https://i.scdn.co/image/1fda84053f7a90280cfe4823a47493f10c8e494d",
               "width"=>300},
              {"height"=>64,
               "url"=>
                "https://i.scdn.co/image/266bc7ab39128b0c0bde310ae0ff0f3e2f166a0c",
               "width"=>64}],
            "name"=>"Disgraceland",
            "type"=>"album",
            "uri"=>"spotify:album:1fQBO5rMjjml5ynOiiqPi3"},
          "artists"=>
           [{"external_urls"=>
              {"spotify"=>
                "https://open.spotify.com/artist/7ia4FaCVsbXvhVwagCJk7l"},
             "href"=>"https://api.spotify.com/v1/artists/7ia4FaCVsbXvhVwagCJk7l",
             "id"=>"7ia4FaCVsbXvhVwagCJk7l",
             "name"=>"The Orwells",
             "type"=>"artist",
             "uri"=>"spotify:artist:7ia4FaCVsbXvhVwagCJk7l"}],
          "available_markets"=>["AU", "CA", "US"],
          "disc_number"=>1,
          "duration_ms"=>164000,
          "explicit"=>false,
          "external_ids"=>{"isrc"=>"USAT21401105"},
          "external_urls"=>
           {"spotify"=>"https://open.spotify.com/track/2LJ2VQL1bklQpAnO0Y69a0"},
          "href"=>"https://api.spotify.com/v1/tracks/2LJ2VQL1bklQpAnO0Y69a0",
          "id"=>"2LJ2VQL1bklQpAnO0Y69a0",
          "name"=>"Southern Comfort",
          "popularity"=>50,
          "preview_url"=>
           "https://p.scdn.co/mp3-preview/115d3cc0393302a6baf99b73fda5e507bf2317e7",
          "track_number"=>1,
          "type"=>"track",
          "uri"=>"spotify:track:2LJ2VQL1bklQpAnO0Y69a0"}],
       "limit"=>20,
       "next"=>nil,
       "offset"=>0,
       "previous"=>nil,
       "total"=>2}}
  end
end
