defmodule ElixirRust.DockerPort do
  use GenServer
  require Logger

  ## ------------------------------------------------------------------
  ## API Function Definitions
  ## ------------------------------------------------------------------

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def echo(msg) do
    GenServer.call(__MODULE__, {:send, msg})
  end

  ## ------------------------------------------------------------------
  ## gen_server Function Definitions
  ## ------------------------------------------------------------------

  def init(_) do
    Process.flag(:trap_exit, true)

    port =
      Port.open({:spawn, "docker run -i iex_echo_app"}, [
        :stderr_to_stdout,
        :use_stdio,
        :binary,
        :exit_status,
        {:line, 100}
      ])

    {:ok, %{port: port}}
  end

  def handle_call({:send, msg}, _from, state) do
    true = Port.command(state.port, msg <> "\n")
    {:response, response} = acc_resp(state.port)
    {:reply, response, state}
  end

  def handle_info(msg, state) do
    Logger.error("Unexpected message: #{inspect(msg)}")
    {:noreply, state}
  end

  ## ------------------------------------------------------------------
  ## Internal Function Definitions
  ## ------------------------------------------------------------------

  defp acc_resp(port) do
    acc_resp(port, "")
  end

  defp acc_resp(_port, bin_acc) do
    receive do
      {_port, {:data, {:noeol, bin_data}}} ->
        acc_resp(Port, bin_acc <> bin_data)

      {_port, {:data, {:eol, bin_data}}} ->
        {:response, bin_acc <> bin_data}
    end
  end
end
