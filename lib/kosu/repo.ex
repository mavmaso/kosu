defmodule Kosu.Repo do
  use Ecto.Repo,
    otp_app: :kosu,
    adapter: Ecto.Adapters.Postgres
end
