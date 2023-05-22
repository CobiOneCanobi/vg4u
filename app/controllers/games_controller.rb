class GamesController < ApplicationController
  def index
    @games = RetrieveGamesService.new.retrieve_games
  end

  def show
  end
end
