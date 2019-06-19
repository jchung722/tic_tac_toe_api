defmodule TicTacToeApiWeb.Router do
  use TicTacToeApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicTacToeApiWeb do
    pipe_through :browser
    get "/", PageController, :index
    get "/status", PageController, :status
    get "/winner", PageController, :winner
  end

  # Other scopes may use custom stacks.
  # scope "/api", TicTacToeApiWeb do
  #   pipe_through :api
  # end
end
