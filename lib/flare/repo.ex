defmodule Flare.Repo do
  use Ecto.Repo,
    otp_app: :flare,
    adapter: Ecto.Adapters.SQLite3
end
