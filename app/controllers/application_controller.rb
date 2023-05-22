class ApplicationController < ActionController::Base
  def igdb_api
    @igdb_api ||= IgdbApi.new
  end
end
