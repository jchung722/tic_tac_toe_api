defmodule TicTacToeApiWeb.PageView do
  use TicTacToeApiWeb, :view

  def render("index.json", %{board: board}) do
    %{spots: board.spots}
  end

  def render("status.json", %{result: result}) do
    case result do
      {:play, next_player, current_player, _spots} ->
        %{result: "play", winner: "none"}
      {:win, winner, _spots} ->
        %{result: "win", winner: winner}
      {:tie, _message, _spots} ->
        %{result: "draw", winner: "none"}
    end
  end
end
