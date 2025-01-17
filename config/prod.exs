import Config

# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix assets.deploy` task,
# which you should run after static files are built and
# before starting your production server.
config :juabado, JuabadoWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json",
force_ssl: [rewrite_on: [:x_forwarded_proto]]
# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Juabado.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :my_app, MyApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "ca8405f3-8d95-4dd3-9461-53e8e9fcefd3-user",
  password: "pw-dcb74bbd-f6a8-4e5f-b744-c7e1120b68b1",
  database: "ca8405f3-8d95-4dd3-9461-53e8e9fcefd3",
  hostname: "postgres-free-tier-v2020.gigalixir.com",
  pool_size: 10,
  ssl: false


# config/prod.exs
config :juabado, JuabadoWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4000],  # Use the PORT env var or default to 4000
  url: [scheme: "http", port: 4000]
