class Show < ActiveRecord::Base
  belongs_to :program
  has_many :show_tracks
  has_many :tracks, through: :show_tracks

  def self.find_or_create_from_attributes(show_attributes, program)
    #find those programs that already have been created
    remote_ids = show_attributes.map {|attr_map| attr_map[:remote_id] }
    existing_shows = Show.where(remote_id: remote_ids)

    #figure out which ones need to be created
    found_ids = existing_shows.pluck(:remote_id)
    need_creation_remote_ids = show_attributes.reject { |raw_show_attrs| found_ids.include?(raw_show_attrs[:remote_id]) }
    new_shows = need_creation_remote_ids.map do |raw_show_attrs|
      Show.create(remote_id: raw_show_attrs[:remote_id], program_id: program.id, date: Time.parse(raw_show_attrs[:date]))
    end
  end

  def remote_sync
    #request show page and scrap song info
  end
end
