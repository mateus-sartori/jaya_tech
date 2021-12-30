defmodule JayaTech.Repo do
  use Ecto.Repo,
    otp_app: :jaya_tech,
    adapter: Ecto.Adapters.Postgres
end
