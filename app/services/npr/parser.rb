class Npr::Parser
  attr_reader :response, :stories

  EPISODE_FLAGS = ['unknown', 'programEpisode']

  def initialize(stories)
    @stories = stories
  end

  def parse_episode_ids_and_urls
    parents = find_episode_nodes(@stories)
    # we only need unique episodes from array of episode data
    parents = parents.uniq {|parent| parent.id }
    parents.map {|parent| {id: parent.id, url: get_url_from_parent(parent) } } if parents.length >= 1
  end

  private

  def find_episode_nodes(stories)
    # Each stories will contain an array of parent objects. Gather and flatten and find episode node
    stories.map { |story| story.parents }.flatten.select {|parent| EPISODE_FLAGS.include?(parent.type) }
  end

  def get_url_from_parent(parent)
    parent.links.find {|link| link.type == 'html' }.content
  end
end
