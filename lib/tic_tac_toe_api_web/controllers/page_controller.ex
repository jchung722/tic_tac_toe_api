defmodule TicTacToeApiWeb.PageController do
  use TicTacToeApiWeb, :controller

  def index(conn, _params) do
    board = %Board{}
    render(conn, "index.json", board: board)
  end

  def status(conn, %{"spots" => spots, "next_player" => next_player, "current_player" => current_player}) do
    result = build_result(spots, next_player, current_player)
    render(conn, "status.json", result: result)
  end

  defp build_result(spots, next_player, current_player) do
    player1 = %Player{symbol: next_player}
    player2 = %Player{symbol: current_player}
    spots_list = Jason.decode!(spots)
                 |> ReactAdapter.swap_marks_with_players(player1, player2)
    Status.result(spots_list, next_player, current_player)
  end

  def winner(conn, %{"spots" => spots}) do
    win_result = Jason.decode!(spots)
                 |> Status.winning_marks
    render(conn, "winner.json", win_result: win_result)
  end

end
