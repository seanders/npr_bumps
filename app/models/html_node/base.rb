class HtmlNode::Base
  def initialize(musicwrap_node)
    @musicwrap_node = musicwrap_node
  end

  def build_track_attributes
    raise NotImplemented, "build_track_attributes not implemented in base class"
  end
end
