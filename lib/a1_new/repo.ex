defmodule A1New.Repo do
  use Ecto.Repo,
    otp_app: :a1_new,
    adapter: Ecto.Adapters.Postgres
end
