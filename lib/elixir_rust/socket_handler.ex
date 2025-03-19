defmodule ElixirRust.SocketHandler do
  @behaviour :ranch_protocol
  require Logger

  def start_link(ref, transport, opts) do
    pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, transport, opts])
    :erlang.register(:socket_handler, pid)
    {:ok, pid}
  end

  def echo(msg) do
    :socket_handler
    |> :erlang.whereis()
    |> GenServer.call({:send, msg})
  end

  def init(ref, transport, _opts) do
    Logger.info("Client connected")
    {:ok, socket} = :ranch.handshake(ref)
    :gen_server.enter_loop(__MODULE__, [], %{socket: socket, transport: transport})
  end

  def handle_call({:send, msg}, _from, state) do
    :gen_tcp.send(state.socket, msg)

    case :gen_tcp.recv(state.socket, 0, 5000) do
      {:ok, response} ->
        {:reply, response, state}

      {:error, reason} ->
        {:reply, {:error, reason}, state}
    end
  end

  def handle_info(msg, state) do
    Logger.info("Received message: #{inspect(msg)}")
    {:noreply, state}
  end
end
