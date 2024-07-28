defmodule JuaBado.Repo do
  use Ecto.Repo,
    otp_app: :juaBado,
    adapter: Ecto.Adapters.Postgres
end
