defmodule juabado.Repo do
  use Ecto.Repo,
    otp_app: :juabado,
    adapter: Ecto.Adapters.Postgres
end
