defmodule ClusterTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ClusterTest.TimeServer
      # Starts a worker by calling: ClusterTest.Worker.start_link(arg)
      # {ClusterTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ClusterTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
