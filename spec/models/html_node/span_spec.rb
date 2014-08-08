require 'spec_helper'

describe HtmlNode::Span do

  describe '#build_track_attributes' do
    context 'with musicwrap with containing text for artist and track title' do
      before(:each) do
        musicwrap_span = Nokogiri::HTML(open(Rails.root + "spec/mock_html/music_wrap_span.html"))
        @span = HtmlNode::Span.new(musicwrap_span)
      end

      it 'should return a hash with the track title' do
        expect(@span.build_track_attributes[:track_title]).to eq("Bitch, Don't Kill My Vibe")
      end

      it 'should return a hash with the artist name' do
        expect(@span.build_track_attributes[:artist_name]).to eq("Kendrick Lamar")
      end
    end

    context 'with musicwrap with containing only track title information' do
      before(:each) do
        musicwrap_span = Nokogiri::HTML(open(Rails.root + "spec/mock_html/music_wrap_span_no_artist.html"))
        @span = HtmlNode::Span.new(musicwrap_span)
      end

      it 'should return a hash with the track title' do
        expect(@span.build_track_attributes[:track_title]).to eq("Deia - Electromana")
      end

    end
  end


end
