require 'igdb_api'

class RetrieveGamesService
  def initialize
    @igdb_api = IgdbApi.new
  end

  def retrieve_games
    games = []
    game_release_dates = @igdb_api.release_dates
    game_ids = game_release_dates.map { |game_release_date| game_release_date['game'] }.join(',')
    game_names = @igdb_api.games("fields name; where id = (#{game_ids});")
    game_covers = @igdb_api.covers("fields game, url; where game = (#{game_ids});")

    game_release_dates.each do |game_release_date|
      game_name = game_names.find { |g| g['id'] == game_release_date['game'] }
      game_cover = game_covers.find { |c| c['game'] == game_release_date['game'] }
      game_platform = @igdb_api.platforms("fields name; where id = #{game_release_date['platform']};").first
      game = Game.new(game_release_date['game'],
                      name: game_name['name'],
                      cover: game_cover,
                      release_date: game_release_date['date'],
                      platform: game_platform['name'])
      games << game
    end
    games
  end
end
