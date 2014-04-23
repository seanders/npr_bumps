class ShowSongScaffold
  attr_reader :show, :raw_html

  def initialize(show, raw_html)
    @show = show
    @raw_html = raw_html
  end

  # need to loop through each show object and create Tracks and ShowTracks

end
