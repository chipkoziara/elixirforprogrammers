defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally) # passing through tally with assigns
  end

  def make_move(conn, params) do
    #raise inspect(params) # to see what existing params are
    guess = params["make_move"]["guess"]
    tally =
      conn
      |> get_session(:game) # grabs :game stored using put_session
      |> Hangman.make_move(guess)

    put_in(conn.params["make_move"]["guess"], "") # modify conn to clear guess
    |> render("game_field.html", tally: tally) # pass updated conn through
  end
end
