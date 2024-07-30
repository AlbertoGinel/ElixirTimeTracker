defmodule JuaBado.Repo do
  use Ecto.Repo,
    otp_app: :JuaBado,
    adapter: Ecto.Adapters.Postgres
end
