defmodule ElixirRust.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # File.rm_rf("/tmp/elixir_rust.sock")

    :ranch.start_listener(
      :unix_socket,
      :ranch_tcp,
      %{
        max_connections: 10,
        num_acceptors: 1,
        socket_opts: [
          {:ip, {0, 0, 0, 0}},
          {:port, 8888}
          # {:ip, {:local, "/tmp/elixir_rust.sock"}}
        ]
      },
      ElixirRust.SocketHandler,
      %{}
    )

    children = [
      ElixirRust.Port,
      ElixirRust.DockerPort
      # ElixirRust.UnixSocket
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirRust.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
