defmodule ReactAdapter do

  def swap_marks_with_players([], _player1, _player2), do: []

  def swap_marks_with_players([head | tail], player1, player2) do
    cond do
      player1.symbol == head ->
        [player1] ++ swap_marks_with_players(tail, player1, player2)
      player2.symbol == head ->
        [player2] ++ swap_marks_with_players(tail, player1, player2)
      true ->
        [head] ++ swap_marks_with_players(tail, player1, player2)
    end
  end
end
