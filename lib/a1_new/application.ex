defmodule A1New.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      A1New.Repo,
      # Start the Telemetry supervisor
      A1NewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: A1New.PubSub},
      # Start the Endpoint (http/https)
      A1NewWeb.Endpoint
      # Start a worker by calling: A1New.Worker.start_link(arg)
      # {A1New.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: A1New.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    A1NewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
