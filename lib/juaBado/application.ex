defmodule Juabado.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JuabadoWeb.Telemetry,
      Juabado.Repo,
      {DNSCluster, query: Application.get_env(:Juabado, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Juabado.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Juabado.Finch},
      # Start a worker by calling: Juabado.Worker.start_link(arg)
      # {Juabado.Worker, arg},
      # Start to serve requests, typically the last entry
      JuabadoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Juabado.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JuabadoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
