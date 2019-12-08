defmodule Hangman.Server do

  alias Hangman.Game

  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil) # create a new process, and start calling callbacks
  end

  def init(_) do
    { :ok, Game.new_game() }
  end

  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)
    { :reply, tally, game } # return_three_element_tuple
  end

  def handle_call({ :tally }, _from, game) do
    { :reply, Game.tally(game), game } # just need tally; game is unchanged
  end

end
