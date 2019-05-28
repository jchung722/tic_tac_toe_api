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

    assert json_response(conn, 200)["result"] === "play"
    assert json_response(conn, 200)["winner"] === "none"
  end

  test "Gets game status for board with winning row as win", %{conn: conn} do
    spots = "[\"X\", \"X\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["result"] === "win"
    assert json_response(conn, 200)["winner"] === "X"
  end

  test "Gets game status for board with winning column as win", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"O\", \"X\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["result"] === "win"
    assert json_response(conn, 200)["winner"] === "X"
  end

  test "Gets game status for board with winning diagonal as win", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"O\", \"O\", \"X\", \"X\"]"
    next_player = "X"
    current_player = "O"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["result"] === "win"
    assert json_response(conn, 200)["winner"] === "O"
  end

  test "Gets game status for full board with no win as tie", %{conn: conn} do
    spots = "[\"O\", \"X\", \"O\", \"X\", \"O\", \"X\", \"X\", \"O\", \"X\"]"
    next_player = "O"
    current_player = "X"

    conn = get(conn, "/status", %{spots: spots, next_player: next_player, current_player: current_player})

    assert json_response(conn, 200)["result"] === "draw"
    assert json_response(conn, 200)["winner"] === "none"
  end
end
