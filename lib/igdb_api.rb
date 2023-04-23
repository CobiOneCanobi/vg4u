class IgdbApi
  include HTTParty
  base_uri ENV['IGDB_URL']

  #TODO add error handling for httparty requests
  def initialize
    response = self.class.post("https://id.twitch.tv/oauth2/token?client_id=#{ENV['TWITCH_CLIENT_ID']}&client_secret=#{ENV['TWITCH_CLIENT_SECRET']}&grant_type=client_credentials
")
    access_token = response.parsed_response['access_token']
    @header = { headers: {'Client-ID' => ENV['TWITCH_CLIENT_ID'], 'Authorization' => "Bearer #{access_token}"} }
  end

  def games
    self.class.post('/games', @header)
  end
end
