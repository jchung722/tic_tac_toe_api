defmodule TicTacToeApiWeb.PageView do
  use TicTacToeApiWeb, :view

  def render("index.json", %{board: board}) do
    %{spots: board.spots}
  end

  def render("status.json", %{result: result}) do
    case result do
      {:play, next_player, current_player, _spots} ->
        %{result: "play", current_player: current_player, next_player: next_player}
      {:win, winner, _spots} ->
        %{result: "wins", Winner: winner}
      {:tie, _message, _spots} ->
        %{result: "TIE"}
    end
  end
end
