defmodule TicTacToeApiWeb.PageController do
  use TicTacToeApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
