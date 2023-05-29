require 'igdb_api'

class RetrieveGamesService
  def initialize(igdb_api = IgdbApi.new)
    @igdb_api = igdb_api
  end

  def retrieve_games(platform = 6)
    games = []
    current_time_ms = Time.now.to_f.to_i
    game_release_dates = @igdb_api.release_dates("fields date, game.name, game.cover.url, platform.name;
      where platform = #{platform} & date > #{current_time_ms};
      sort date asc;")

    game_release_dates.each do |game_release_date|
      game = Game.new(game_release_date['game']['id'],
                      name: game_release_date['game']['name'],
                      cover: game_release_date['game']['cover'],
                      release_date: game_release_date['date'],
                      platform: game_release_date['platform']['name'])
      games << game
    end
    games
  end
end
