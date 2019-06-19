defmodule TicTacToeApiWeb.PageControllerTest do
  use TicTacToeApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert json_response(conn, 200)["spots"] === ["1", "2", "3",
                                                  "4", "5", "6",
                                                  "7", "8", "9"]
  end

  test "Gets game status for new game as continue play", %{conn: conn} do
    spots = "[\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\"]"
    next_player = "X"
    current_player = "O"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["status"] === "in progress"
  end

  test "Gets game status for board where player X has winning row", %{conn: conn} do
    spots = "[\"X\", \"X\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["status"] === "X wins"
  end

  test "Gets game status for board where player X has winning column", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"O\", \"X\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["status"] === "X wins"
  end

  test "Gets game status for board where player O has winning diagonal", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\", \"X\"]"
    next_player = "X"
    current_player = "O"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["status"] === "O wins"
  end

  test "Gets game status for full board with no win as tie", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["status"] === "draw"
  end

  test "returns no indices for a new game", %{conn: conn} do
    spots = "[\"1\", \"2\", \"3\", \"4\", \"5\", \"6\", \"7\", \"8\", \"9\"]"

    conn = get(conn, "/winner", %{spots: spots})

    assert json_response(conn, 200)["index_list"] == []
  end

  test "returns winning indices for a winner in a row", %{conn: conn} do
    spots = "[\"X\", \"X\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\"]"

    conn = get(conn, "/winner", %{spots: spots})

    assert json_response(conn, 200)["index_list"] == [0, 1, 2]
  end

  test "returns winning indices for a winner in a column", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"O\", \"X\", \"X\"]"

    conn = get(conn, "/winner", %{spots: spots})

    assert json_response(conn, 200)["index_list"] == [1, 4, 7]
  end

  test "returns winning indices for a winner in a diagonal", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\", \"X\"]"

    conn = get(conn, "/winner", %{spots: spots})

    assert json_response(conn, 200)["index_list"] == [2, 4, 6]
  end

  test "returns no winning indices for a game that is a draw", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"X\"]"

    conn = get(conn, "/winner", %{spots: spots})

    assert json_response(conn, 200)["index_list"] == []
  end
end
