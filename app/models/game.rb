class Game
  # TODO review setter methods
  attr_reader :id, :name, :cover_url, :release_date, :platform

  NO_COVER_URL = 'https://images.igdb.com/igdb/image/upload/t_thumb/nocover.jpg'.freeze

  def initialize(id, options = {})
    @id = id
    @name = options[:name] || nil
    @cover_url = options[:cover].nil? ? NO_COVER_URL : "https:#{options[:cover]['url']}"
    @release_date = Time.at(options[:release_date]) || nil
    @platform = options[:platform] || nil
  end
end
