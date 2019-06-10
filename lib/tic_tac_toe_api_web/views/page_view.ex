defmodule TicTacToeApiWeb.PageView do
  use TicTacToeApiWeb, :view

  def render("index.json", %{board: board}) do
    %{spots: board.spots}
  end

  def render("status.json", %{result: result}) do
    case result do
      {:play, _next_player, _current_player, _spots} ->
        %{status: "in progress"}
      {:win, "X", _spots} ->
        %{status: "X wins"}
      {:win, "O", _spots} ->
        %{status: "O wins"}
      {:tie, _message, _spots} ->
        %{status: "draw"}
    end
  end

  def render("computer.json", %{move: move}) do
    %{move: move}
  end
end
