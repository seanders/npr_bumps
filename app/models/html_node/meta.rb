class HtmlNode::Meta < HtmlNode::Base

  def initialize(musicwrap_node)
    @meta_node = musicwrap_node.css("ol.mi-meta")
  end

  def build_track_attributes
    {
      track_title: get_info_from_meta_node('Track', @meta_node),
      artist_name: get_info_from_meta_node('Artist', @meta_node),
      album_name:  get_info_from_meta_node('Album', @meta_node),
      label_name:  get_info_from_meta_node('Label', @meta_node)
    }
  end

private
  def get_info_from_meta_node(term_type, node)
    #   <dt>Artist</dt>
    #   <dd>Curumin</dd>
    term_node = node.search("dt:contains('#{term_type}')")
    # No data
    return nil if term_node.empty?
    get_description(term_node)
  end

  def get_description(term_node)
    result = term_node.first.next_element.inner_text.strip
    # Sometimes the markup might have an empty <dd>
    result.empty? ? nil : result
  end
end
