class IgdbApi
  include HTTParty
  base_uri 'https://api.igdb.com/v4'

  # TODO add error handling for httparty requests
  def initialize
    response = self.class.post("https://id.twitch.tv/oauth2/token?client_id=#{ENV['TWITCH_CLIENT_ID']}&client_secret=#{ENV['TWITCH_CLIENT_SECRET']}&grant_type=client_credentials
")
    access_token = response.parsed_response['access_token']
    @headers = {'Client-ID' => ENV['TWITCH_CLIENT_ID'], 'Authorization' => "Bearer #{access_token}"}
  end

  # Sample output:
  # [{"id"=>76870, "name"=>"War Theatre"}]
  # name: name of the game
  def games(body = 'fields *;')
    self.class.post('/games', headers: @headers, body: body)
  end

  # Sample output:
  # [{"id"=>170111, "date"=>1552953600, "game"=>76870, "platform"=>48}]
  # date: Unix timestamp in ms of the date of the release
  # game: Reference id of Game
  # platform: Reference id of Platform
  def release_dates(body = 'fields game, date, platform;')
    response = self.class.post('/release_dates', headers: @headers, body: body)
  end

  # Sample output:
  # [{"id"=>2473, "game"=>76870, "url"=> image url }]
  # game: Reference id of Game
  # url: url of cover image
  def covers(body = 'fields *;')
    response = self.class.post('/covers', headers: @headers, body: body)
  end

  # TODO move into video game object
  def merging_video_game_data
    game_release_dates = release_dates
    game_ids = game_release_dates.map { |release_date| release_date['game'] }.join(',')
    games = games("fields name; where id = (#{game_ids});")
    covers = covers("fields game, url; where game = (#{game_ids});")
    no_cover_url = '//images.igdb.com/igdb/image/upload/t_thumb/nocover.jpg'

    game_release_dates.each do |release_date|
      game = games.find { |game| game['id'] == release_date['game'] }
      cover = covers.find { |cover| cover['game'] == release_date['game'] }
      cover_url = cover.nil? ? no_cover_url : cover['url']
      release_date.merge!('name' => game['name'], 'url' => cover_url)
    end
    game_release_dates
  end
end
