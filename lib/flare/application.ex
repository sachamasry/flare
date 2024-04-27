defmodule Flare.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FlareWeb.Telemetry,
      # Start the Ecto repository
      Flare.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Flare.PubSub},
      # Start Finch
      {Finch, name: Flare.Finch},
      # Start the Endpoint (http/https)
      FlareWeb.Endpoint,
      # Start a worker by calling: Flare.Worker.start_link(arg)
      # {Flare.Worker, arg}
     {Beacon, sites: [[site: :flare, endpoint: FlareWeb.Endpoint]]}
]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flare.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlareWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
