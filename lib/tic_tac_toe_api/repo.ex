defmodule TicTacToeApi.Repo do
  use Ecto.Repo,
    otp_app: :tic_tac_toe_api,
    adapter: Ecto.Adapters.Postgres
end
