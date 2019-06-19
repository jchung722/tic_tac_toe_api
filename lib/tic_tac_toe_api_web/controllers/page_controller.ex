defmodule TicTacToeApiWeb.PageController do
  use TicTacToeApiWeb, :controller

  @env Application.get_env(:tic_tac_toe_api, :env)

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

  def computer(conn, %{"spots" => spots, "computer" => computer, "human" => human}) do
    move = board_with_players(spots, computer, human)
           |> get_computer_move(@env)

    render(conn, "computer.json", move: move)
  end

  defp get_computer_move(board, :test) do
    Computer.random_move(board, :rand.seed(:exs1024, {1, 2, 3}))
  end

  defp get_computer_move(board, _env) do
    Computer.random_move(board)
  end

  def winner(conn, %{"spots" => spots}) do
    win_result = Jason.decode!(spots)
                 |> Status.winning_marks
    render(conn, "winner.json", win_result: win_result)
  end

end
