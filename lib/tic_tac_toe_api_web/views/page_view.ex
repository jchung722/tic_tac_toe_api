defmodule TicTacToeApiWeb.PageView do
  use TicTacToeApiWeb, :view

  def render("index.json", %{board: board}) do
    %{spots: board.spots}
  end

  def render("game.json", %{result: result}) do
    case result do
      {:play, next_player, current_player, spots} ->
        %{result: "play", current_player: current_player, next_player: next_player, spots: spots}
    end
  end
end
