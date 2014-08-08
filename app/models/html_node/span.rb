class HtmlNode::Span < HtmlNode::Base
  def build_track_attributes
    {
      track_title: parse_track_title,
      artist_name: parse_artist_name
    }
  end

  def parse_track_title
    @musicwrap_node.css('.songTitle').children.first.text.strip
  end

  def parse_artist_name
     artist_node = @musicwrap_node.css('.artist')
     return if artist_node.empty?
     artist_node.first.text.strip
  end
end
