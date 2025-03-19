defmodule ElixirRust.UnixSocket do
  use GenServer
  require Logger

  @socket_path "/tmp/elixir_rust.sock"

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def echo(msg) do
    GenServer.call(__MODULE__, {:send, msg})
  end

  def init(_opts) do
    File.rm(@socket_path)

    # docker_run_cmd =
    #   ~c"docker run --rm -it -v /tmp/elixir_rust.sock:/tmp/elixir_rust.sock unix_socket"

    # Logger.info("Running #{:os.cmd(docker_run_cmd)}")

    case :gen_tcp.listen(0, [
           :binary,
           {:ifaddr, {:local, @socket_path}},
           {:active, false},
           {:packet, 0},
           {:reuseaddr, true}
         ]) do
      {:ok, socket} ->
        Logger.info("Unix socket listening on #{@socket_path}")
        # File.chmod(@socket_path, 0o777)
        send(self(), :accept)
        {:ok, %{listen_socket: socket, client_socket: nil}}

      {:error, reason} ->
        Logger.error("Failed to open unix socket: #{inspect(reason)}")
        {:stop, reason}
    end
  end

  def handle_info(:accept, %{client_socket: socket} = state) when not is_nil(socket) do
    Logger.info("Stopping accept loop")
    {:noreply, state}
  end

  def handle_info(:accept, %{listen_socket: listen_socket, client_socket: nil} = state) do
    Logger.info("Waiting for client connection")

    case :gen_tcp.accept(listen_socket, 0) do
      {:ok, client_socket} ->
        Logger.info("New client connected")
        {:noreply, %{state | client_socket: client_socket}}

      _ ->
        Process.send_after(self(), :accept, 100)
        {:noreply, state}
    end
  end

  def handle_info(message, state) do
    Logger.error("Unexpected message: #{inspect(message)}")
    {:noreply, state}
  end

  def handle_call({:send, msg}, _from, %{client_socket: socket} = state) do
    case :gen_tcp.send(socket, msg) do
      :ok ->
        case :gen_tcp.recv(socket, 0, 5000) do
          {:ok, response} ->
            {:reply, response, state}

          {:error, reason} ->
            Logger.error("Failed to receive response: #{inspect(reason)}")
            {:reply, {:error, reason}, state}
        end

      {:error, :closed} ->
        Logger.error("Client disconnected")
        send(self(), :accept)
        {:reply, {:error, :closed}, %{state | client_socket: nil}}

      {:error, reason} ->
        Logger.error("Failed to send message: #{inspect(reason)}")
        {:reply, {:error, reason}, state}
    end
  end

  def terminate(_reason, %{listen_socket: socket}) do
    :gen_tcp.close(socket)
    File.rm(@socket_path)
    :ok
  end
end
