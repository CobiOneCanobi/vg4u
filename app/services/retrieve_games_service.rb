class RetrieveGamesService
  def initialize
    @igdb_api = IgdbApi.new
  end

  # TODO move result into array of game objects
  def retrieve_games
    game_release_dates = @igdb_api.release_dates
    game_ids = game_release_dates.map { |release_date| release_date['game'] }.join(',')
    games = @igdb_api.games("fields name; where id = (#{game_ids});")
    covers = @igdb_api.covers("fields game, url; where game = (#{game_ids});")
    no_cover_url = '//images.igdb.com/igdb/image/upload/t_thumb/nocover.jpg'

    game_release_dates.each do |game_release_date|
      game = games.find { |g| g['id'] == game_release_date['game'] }
      cover = covers.find { |c| c['game'] == game_release_date['game'] }
      cover_url = cover.nil? ? no_cover_url : cover['url']
      game_release_date.merge!('name' => game['name'], 'url' => cover_url)
    end
    game_release_dates
  end
end
