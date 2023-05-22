class GamesController < ApplicationController
  def index
    @games = RetrieveGamesService.new(igdb_api).retrieve_games
  end

  def show
  end
end
