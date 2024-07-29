# General application configuration
import Config

config :juabado,
  ecto_repos: [JuaBado.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :juabado, JuaBadoWeb.Endpoint,
  #url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: JuaBadoWeb.ErrorHTML, json: JuaBadoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: JuaBado.PubSub,
  live_view: [signing_salt: "xOaoOO0Z"]


# Configuring the PubSub Adapter
config :juabado, JuaBadoWeb.PubSub,
  adapter: Phoenix.PubSub.PG2

# Configures the mailer
config :juabado, JuaBado.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  juabado: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  juabado: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
# config/config.exs

config :juabado, JuaBadoWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4000],  # Default PORT configuration
  url: [host: "postgres-free-tier-v2020.gigalixir.com"]
