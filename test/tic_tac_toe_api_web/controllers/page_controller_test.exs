defmodule TicTacToeApiWeb.PageControllerTest do
  use TicTacToeApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert json_response(conn, 200)["spots"] === ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  # test "GET /game", %{conn: conn} do
  #   conn = get(conn, "/game")
  #   assert conn.status == 200
  # end

  test "GET /game for new game", %{conn: conn} do
    spots = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    next_player = "X"
    current_player = "O"
    conn = get(conn, "/game", %{spots: spots, next_player: next_player, current_player: current_player})
    assert json_response(conn, 200)["result"] === "play"
    assert json_response(conn, 200)["next_player"] === "X"
    assert json_response(conn, 200)["current_player"] === "O"
    assert json_response(conn, 200)["spots"] === ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end
end
