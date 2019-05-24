defmodule TicTacToeApiWeb.PageController do
  use TicTacToeApiWeb, :controller

  def index(conn, _params) do
    board = %Board{}
    render(conn, "index.json", board: board)
  end

  def game(conn, %{"spots" => spots, "next_player" => next_player, "current_player" => current_player}) do
    spots_list = String.replace(spots, ~r/[][\",]/, "")
                 |> String.split(" ")
    result = Status.result(spots_list, next_player, current_player)
    render(conn, "game.json", result: result)
  end


end
