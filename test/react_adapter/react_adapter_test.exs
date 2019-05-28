defmodule ReactAdapterTest do
  use ExUnit.Case

  test "swaps empty board with empty board" do
    spots = ["1", "2", "3",
            "4", "5", "6",
            "7", "8", "9"]
    playerX = %Player{symbol: "X"}
    playerO = %Player{symbol: "O"}

    assert ReactAdapter.swap_marks_with_players(spots, playerX, playerO) == ["1", "2", "3",
                                                                             "4", "5", "6",
                                                                             "7", "8", "9"]
  end

  test "swaps board with marks into board with players" do
    spots = ["X", "O", "O",
             "O", "O", "X",
             "X", "X", "O"]

    playerX = %Player{symbol: "X"}
    playerO = %Player{symbol: "O"}

    assert ReactAdapter.swap_marks_with_players(spots, playerX, playerO) == [playerX, playerO, playerO,
                                                                            playerO, playerO, playerX,
                                                                            playerX, playerX, playerO]


  end
end
