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
    spots_list = String.replace(spots, ~r/[][\",]/, "")
                 |> String.split(" ")
                 |> swap_symbol_with_player(player1, player2)
    Status.result(spots_list, next_player, current_player)
  end

  defp swap_symbol_with_player([], _player1, _player2), do: []

  defp swap_symbol_with_player([head | tail], player1, player2) do
    cond do
      player1.symbol == head ->
        [player1] ++ swap_symbol_with_player(tail, player1, player2)
      player2.symbol == head ->
        [player2] ++ swap_symbol_with_player(tail, player1, player2)
      true ->
        [head] ++ swap_symbol_with_player(tail, player1, player2)
    end
  end


end
