defmodule Juabado.Repo do
  use Ecto.Repo,
    otp_app: :Juabado,
    adapter: Ecto.Adapters.Postgres
end
