defmodule Loggregate.Repo do
  use Ecto.Repo,
    otp_app: :loggregate,
    adapter: Ecto.Adapters.Postgres
end
