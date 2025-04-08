defmodule PocIntelbrasIntegration.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PocIntelbrasIntegrationWeb.Telemetry,
      PocIntelbrasIntegration.Repo,
      {DNSCluster, query: Application.get_env(:poc_intelbras_integration, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PocIntelbrasIntegration.PubSub},
      # Start a worker by calling: PocIntelbrasIntegration.Worker.start_link(arg)
      # {PocIntelbrasIntegration.Worker, arg},
      # Start to serve requests, typically the last entry
      PocIntelbrasIntegrationWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PocIntelbrasIntegration.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PocIntelbrasIntegrationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
