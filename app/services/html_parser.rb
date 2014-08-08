# NB: Format of ol-meta node
# <ol class="mi-meta">
#   <dt>Artist</dt>
#   <dd>Curumin</dd>
#   <dt>Track</dt>
#   <dd>Blimblim</dd>
#   <dt>Album</dt>
#   <dd>Arrocha!</dd>
#   <dt>Label</dt>
#   <dd>Six Degrees</dd>
# </ol>

class HtmlParser
  def build_track_attributes_array_from_html(html)
    Nokogiri::HTML(html).css(".musicwrap").map do |musicwrap_node|
      track_parser_object = node_factory(musicwrap_node)
      track_parser_object.build_track_attributes
    end
  end

private
  def node_factory(musicwrap_node)
    if musicwrap_node.css("ol.mi-meta").present?
      HtmlNode::Meta.new(musicwrap_node)
    else
      HtmlNode::Span.new(musicwrap_node)
    end
  end
end
