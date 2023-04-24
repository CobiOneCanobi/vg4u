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

  def games(body = 'fields *;')
    self.class.post('/games', headers: @headers, body: body)
  end

  def release_dates(body = 'fields game, date, platform;')
    response = self.class.post('/release_dates', headers: @headers, body: body)
    game_ids = response.map {|game| game['game'] }.join(',')
    game_names = games("fields name; where id = (#{game_ids});")
    # TODO move logic that is not related to grabbing release dates outside of method
  end
end
