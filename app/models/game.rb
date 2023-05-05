class Game
  attr_accessor :id, :name, :cover_url, :release_date, :platform

  def initialize(id, options = {})
    @id = id
    @name = options[:name] || nil
    @cover_url = options[:cover_url] || nil
    @release_date = options[:release_date] || nil
    @platform = options[:platform] || nil
  end
end
