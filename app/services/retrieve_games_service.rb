class RetrieveGamesService
  def initialize
    @igdb_api = IgdbApi.new
  end

  def retrieve_games
    games = []
    game_release_dates = @igdb_api.release_dates
    game_ids = game_release_dates.map { |release_date| release_date['game'] }.join(',')
    game_names = @igdb_api.games("fields name; where id = (#{game_ids});")
    covers = @igdb_api.covers("fields game, url; where game = (#{game_ids});")
    no_cover_url = '//images.igdb.com/igdb/image/upload/t_thumb/nocover.jpg'

    game_release_dates.each do |game_release_date|
      game_name = game_names.find { |g| g['id'] == game_release_date['game'] }
      cover = covers.find { |c| c['game'] == game_release_date['game'] }
      cover_url = cover.nil? ? no_cover_url : cover['url']
      game = Game.new(game_release_date['game'], name: game_name['name'], cover_url: cover_url, release_date: game_release_date['date'], platform: game_release_date['platform'] )
      games << game
    end
    games
  end
end
