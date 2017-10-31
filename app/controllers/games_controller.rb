class GamesController < ApplicationController
  autocomplete :game, :name
end
