defmodule TicTacToeApiWeb.PageControllerTest do
  use TicTacToeApiWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert json_response(conn, 200)["spots"] === ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end
end
