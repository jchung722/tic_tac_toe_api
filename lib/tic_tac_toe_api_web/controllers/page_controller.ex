defmodule TicTacToeApiWeb.PageController do
  use TicTacToeApiWeb, :controller

  def index(conn, _params) do
    board = %Board{}
    render(conn, "index.json", board: board)
  end

  def status(conn, %{"spots" => spots, "next_player" => next_player, "current_player" => current_player}) do
    result = board_with_players(spots, next_player, current_player)
             |> Status.result(next_player, current_player)
    render(conn, "status.json", result: result)
  end

  defp board_with_players(spots, player1, player2) do
    player1 = %Player{symbol: player1}
    player2 = %Player{symbol: player2}
    Jason.decode!(spots)
    |> ReactAdapter.swap_marks_with_players(player1, player2)
  end

  def winner(conn, %{"spots" => spots}) do
    win_result = Jason.decode!(spots)
                 |> Status.winning_marks
    render(conn, "winner.json", win_result: win_result)
  end

end
